import Foundation

public struct Settings {
    
    public init() {}
    
    public func saveEmail(email: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(email, forKey: Constants.emailKey)
        defaults.synchronize()
    }
    
    public func email() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let email = defaults.stringForKey(Constants.emailKey)
        
        if email != nil {
            return email!
        } else {
            return ""
        }
    }
}
