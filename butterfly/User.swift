import Foundation
import Parse

public struct User {
    public static func isSignedOut() -> Bool {
        return PFUser.currentUser() == nil
    }
}
    
