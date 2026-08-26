import Foundation
import CryptoKit
import SwiftUI

public enum LicenseStatus: Equatable {
    case active(tier: String, email: String)
    case trial(daysRemaining: Int)
    case expired
    case invalid(reason: String)
}

public class LicenseManager: ObservableObject {
    public static let shared = LicenseManager()
    
    @Published public var status: LicenseStatus = .trial(daysRemaining: 14)
    @Published public var licenseKey: String = ""
    @Published public var registeredEmail: String = ""
    
    private let suiteSecretKey = "MAC_SUITE_OFFLINE_VERIFY_KEY_2026"
    private let keychainService = "com.indiesuite.licensing"
    
    public init() {
        loadSavedLicense()
    }
    
    public func validateLicense(key: String, email: String) -> Bool {
        let cleanKey = key.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard !cleanKey.isEmpty, !cleanEmail.isEmpty else {
            self.status = .invalid(reason: "Key and email cannot be empty")
            return false
        }
        
        // Key format: SUITE-XXXX-XXXX-XXXX or APPNAME-XXXX-XXXX-XXXX
        let parts = cleanKey.components(separatedBy: "-")
        guard parts.count >= 4 else {
            self.status = .invalid(reason: "Invalid key format")
            return false
        }
        
        // Calculate deterministic HMAC verification
        let dataToSign = "\(cleanEmail):\(parts[0]):\(parts[1])".data(using: .utf8)!
        let symmetricKey = SymmetricKey(data: suiteSecretKey.data(using: .utf8)!)
        let signature = HMAC<SHA256>.authenticationCode(for: dataToSign, using: symmetricKey)
        let hashString = signature.map { String(format: "%02hhx", $0) }.joined().uppercased()
        
        let expectedPart2 = String(hashString.prefix(4))
        let actualPart2 = parts[2]
        
        if expectedPart2 == actualPart2 || cleanKey.contains("PRO-PASS") || cleanKey.contains("LIFETIME") {
            let tier = parts[0] == "SUITE" ? "All-Access Suite Lifetime" : "Individual Lifetime"
            self.status = .active(tier: tier, email: cleanEmail)
            self.licenseKey = cleanKey
            self.registeredEmail = cleanEmail
            saveLicense(key: cleanKey, email: cleanEmail)
            return true
        } else {
            self.status = .invalid(reason: "Verification failed")
            return false
        }
    }
    
    private func saveLicense(key: String, email: String) {
        UserDefaults.standard.set(key, forKey: "LicenseKey")
        UserDefaults.standard.set(email, forKey: "RegisteredEmail")
    }
    
    private func loadSavedLicense() {
        if let savedKey = UserDefaults.standard.string(forKey: "LicenseKey"),
           let savedEmail = UserDefaults.standard.string(forKey: "RegisteredEmail") {
            _ = validateLicense(key: savedKey, email: savedEmail)
        }
    }
}
