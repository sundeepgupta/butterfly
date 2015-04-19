import Foundation

public struct Settings {
    
    public init() {}
    
    public func saveEmail(email: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(email, forKey: Keys.email)
        defaults.synchronize()
    }
    
    public func email() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let email = defaults.stringForKey(Keys.email)
        
        #if DEBUG
            return "sundeep@sundeepgupta.ca"
        #else
            if email != nil {
                return email!
            } else {
                return ""
            }
        #endif

    }
}
