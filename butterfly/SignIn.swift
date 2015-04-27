import Foundation
import Parse

public struct SignIn {
    let email: String
    let password: String
    let success: () -> Void
    let failure: NSError -> Void
    
    public init(email: String,
        password: String,
        success: () -> Void,
        failure: NSError -> Void) {
            self.email = email
            self.password = password
            self.success = success
            self.failure = failure
    }
    
    public func perform() {
        var error: NSError?
        PFUser.logInWithUsername(self.email, password: self.password, error: &error)
        
        if error != nil {
            self.failure(error!)
            println("Error signing up user with email: \(self.email)\nError: \(error!)")
        } else {
            self.success()
            println("Successfully signed up user with email: \(self.email)")
        }
    }
}