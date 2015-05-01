import Foundation
import Parse

public struct User {
    public static func signUp(#email: String, password: String, success: () -> Void, failure: NSError -> Void) {
        
        var error: NSError?
        self.userObject(email: email, password: password).signUp(&error)
        
        if error != nil {
            failure(error!)
            println("Error signing up user with email: \(email)\nError: \(error!)")
        } else {
            success()
            println("Successfully signed up user with email: \(email)")
        }
    }
    
    public static func signIn(#email: String, password: String, success: () -> Void, failure: NSError -> Void) {

        var error: NSError?
        PFUser.logInWithUsername(email, password: password, error: &error)
        
        if error != nil {
            failure(error!)
            println("Error signing up user with email: \(email)\nError: \(error!)")
        } else {
            success()
            println("Successfully signed up user with email: \(email)")
        }
    }
    
    public static func signOut() {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.signOutNotificationName, object: nil)
    }
    
    public static func isSignedOut() -> Bool {
        return PFUser.currentUser() == nil
    }
    
    
    // MARK: Private
    private static func userObject(#email: String, password: String) -> PFUser {
        var user = PFUser()
        user.username = email
        user.password = password
        return user
    }
}

