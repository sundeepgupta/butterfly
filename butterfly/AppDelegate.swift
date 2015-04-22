import UIKit
import Parse

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.setupParse()
        return true
    }
    
    private func setupParse() {
        Parse.setApplicationId(Utils.secretForKey("parseApplicationId"),
            clientKey: Utils.secretForKey("parseClientKey"))
    }
}

