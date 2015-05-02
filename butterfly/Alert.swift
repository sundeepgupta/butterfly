import UIKit

public struct Alert {
    public static func showBasic(#title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(action)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
