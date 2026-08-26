cask "certsentry" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/certsentry-1.0.0.dmg"
  name "Certsentry"
  desc "SSL/TLS certificate expiration tracker for your domains"
  homepage "https://indiesuite.app/apps/certsentry"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Certsentry.app"

  zap trash: [
    "~/Library/Application Support/certsentry",
    "~/Library/Preferences/com.indiesuite.certsentry.plist",
  ]
end
