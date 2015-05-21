import Foundation
import UIKit

// Need this to subclass NSObject so we can add NSNotificaiton observer.
public class Router: NSObject {
    public let rootViewController: UIViewController
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init()
        self.registerForNotifications()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public func showSignIn() {
        self.rootViewController.performSegueWithIdentifier("toSignIn", sender: nil)
    }
    
    func signedOut(notification: NSNotification) {
        self.dismissPresentedViews()
        self.showSignIn()
    }
    
    func reset(notification: NSNotification) {
        let navigationController = rootViewController as! UINavigationController
        navigationController.popToRootViewControllerAnimated(true)
    }
    
    
    // MARK: Private
    private func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "signedOut:", name: Constants.signOutNotificationName, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reset:", name: Constants.resetNotificationName, object: nil)
    }
    
    private func dismissPresentedViews() {
        self.rootViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
