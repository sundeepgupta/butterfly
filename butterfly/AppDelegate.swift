import UIKit
import Parse

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            
            self.showSignIn()
            self.setupParse()
            return true
    }
    
    // MARK: Private
    private func showSignIn() {
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.performSegueWithIdentifier("toSignIn", sender: nil)
    }
    
    private func setupParse() {
        Parse.setApplicationId(Utils.secretForKey("parseApplicationId"),
            clientKey: Utils.secretForKey("parseClientKey"))
    }
}

