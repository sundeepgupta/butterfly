import UIKit

public struct Alert {
    let alertController: UIAlertController
    let viewController: UIViewController

    public init(title: String, message: String, showIn viewController: UIViewController) {
        self.alertController = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        self.alertController.addAction(action)
        
        self.viewController = viewController
    }
    
    public func show() {
        self.viewController
            .presentViewController(self.alertController, animated: true, completion: nil)
    }
}
