import UIKit
import Parse


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("Ntm7aZEBUH4qL1ydhkU3Y5slXmeC97zPZkSquZp4", clientKey: "tFg56Wn0aW1hl7fsSzcAFv6gumxaiMCF8EAio9v8")
                
        return true
    }
}

