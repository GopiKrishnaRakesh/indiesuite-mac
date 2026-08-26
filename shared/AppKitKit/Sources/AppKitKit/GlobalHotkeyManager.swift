import AppKit
import Carbon

public class GlobalHotkeyManager {
    public static let shared = GlobalHotkeyManager()
    
    private var eventHandler: EventHandlerRef?
    private var hotkeyActions: [UInt32: () -> Void] = [:]
    private var nextHotKeyId: UInt32 = 1
    
    private init() {
        installCarbonHandler()
    }
    
    private func installCarbonHandler() {
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        
        InstallEventHandler(
            GetApplicationEventTarget(),
            { (_, event, _) -> OSStatus in
                var hotKeyID = EventHotKeyID()
                let status = GetEventParameter(
                    event,
                    EventParamName(kEventParamDirectObject),
                    EventParamType(typeEventHotKeyID),
                    nil,
                    MemoryLayout<EventHotKeyID>.size,
                    nil,
                    &hotKeyID
                )
                
                if status == noErr {
                    GlobalHotkeyManager.shared.triggerAction(for: hotKeyID.id)
                }
                return noErr
            },
            1,
            &eventType,
            nil,
            &eventHandler
        )
    }
    
    public func registerHotkey(keyCode: UInt32, modifiers: UInt32, action: @escaping () -> Void) -> UInt32 {
        let hotKeyID = EventHotKeyID(signature: OSType(0x53554954), id: nextHotKeyId) // 'SUIT'
        var hotKeyRef: EventHotKeyRef?
        
        let status = RegisterEventHotKey(
            keyCode,
            modifiers,
            hotKeyID,
            GetApplicationEventTarget(),
            0,
            &hotKeyRef
        )
        
        if status == noErr {
            let id = nextHotKeyId
            hotkeyActions[id] = action
            nextHotKeyId += 1
            return id
        }
        return 0
    }
    
    public func triggerAction(for id: UInt32) {
        DispatchQueue.main.async {
            self.hotkeyActions[id]?()
        }
    }
}
