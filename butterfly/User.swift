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
            println("Error signing in user with email: \(email)\nError: \(error!)")
        } else {
            success()
            println("Successfully signed in user with email: \(email)")
        }
    }
    
    public static func signOut() {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.signOutNotificationName, object: nil)
    }
    
    public static func isSignedOut() -> Bool {
        return PFUser.currentUser() == nil
    }
    
    public static func email() -> String {
        return PFUser.currentUser()!.username!
    }
    
    public static func updateCredentials(#email: String, password: String, success: () -> Void, failure: NSError -> Void) {
        var user = PFUser.currentUser()!
        
        if email != "" && email != user.username {
            user.username = email
        }
        
        if password != "" {
            user.password = password
        }
        
        var error: NSError?
        user.save(&error)
        
        if error != nil {
            failure(error!)
            println("Error updating credentials for user with email: \(email)\nError: \(error!)")
        } else {
            success()
            println("Successfully updated credentials for user with email: \(email)")
        }
    }
    
    
    // MARK: Private
    private static func userObject(#email: String, password: String) -> PFUser {
        var user = PFUser()
        user.username = email
        user.password = password
        return user
    }
}

