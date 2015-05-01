import UIKit
import Parse

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: Router!
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            self.window?.makeKeyAndVisible()
            
            self.setupRouter()
            self.setupParse()
            self.checkSignedIn()
            
            return true
    }
    
    // MARK: Private
    private func setupRouter() {
        self.router = Router(rootViewController: self.window!.rootViewController!)
    }
    
    private func setupParse() {
        Parse.setApplicationId(Utils.secretForKey("parseApplicationId"),
            clientKey: Utils.secretForKey("parseClientKey"))
    }
    
    private func checkSignedIn() {
        if User.isSignedOut() {
            self.router.showSignIn()
        }
    }
}

