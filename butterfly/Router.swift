import Foundation
import UIKit

// Need this to subclass NSObject so we can add NSNotificaiton observer.
public class Router: NSObject {
    public let rootViewController: UIViewController
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "signedOut:",
            name: Constants.signOutNotificationName,
            object: nil)
    }
    
    public func showSignIn() {
        self.rootViewController.performSegueWithIdentifier("toSignIn", sender: nil)
    }
    
    func signedOut(notification: NSNotification) {
        self.dismissPresentedViews()
        self.showSignIn()
    }
    
    private func dismissPresentedViews() {
        self.rootViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
