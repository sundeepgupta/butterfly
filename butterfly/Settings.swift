import Foundation

public struct Settings {
    public static func mailSubject() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let subject = defaults.stringForKey("mailSubject")
        
        if subject != nil {
            return subject!
        } else {
            return ""
        }
    }
    
    public static func saveMailSubject(subject: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(subject, forKey: "mailSubject")
        defaults.synchronize()
    }
}
