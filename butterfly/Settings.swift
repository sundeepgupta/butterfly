import Foundation

public struct Settings {
    let defaults: NSUserDefaults
    
    public init(defaults: NSUserDefaults) {
        self.defaults = defaults
    }
    
    public func saveEmail(email: String) {
        self.defaults.setValue(email, forKey: Keys.email)
        self.defaults.synchronize()
    }
    
    public func email() -> String {
        #if DEBUG
            return "sundeep@sundeepgupta.ca"
        #else
            if let email = self.defaults.stringForKey(Keys.email) {
                return email
            } else {
                return ""
            }
        #endif
    }
}
