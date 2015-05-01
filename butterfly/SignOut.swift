import Foundation
import Parse

public struct SignOut {
    public static func perform() {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter()
            .postNotificationName(Constants.signOutNotificationName, object: nil)

    }
}
