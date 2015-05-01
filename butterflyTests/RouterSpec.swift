import Quick
import Nimble
import butterfly
import UIKit

class RouterSpec: QuickSpec {
    override func spec() {
        var subject: Router!
        
        beforeEach {
            let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
            let rootViewController = storyboard.instantiateInitialViewController()
                as! UIViewController
            subject = Router(rootViewController: rootViewController)
            
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = subject.rootViewController
            window.makeKeyAndVisible()
        }
        
        context("When logged out") {
            // Can't get these tests to work properly.
            // For some reason, it won't dismiss the modal. 
            // Also, when debugging, "subject" here is different than "self" in the
            // Router class. Why?
            xit("dismisses all modals") {
                subject.rootViewController
                    .presentViewController(UIViewController(), animated: false, completion: nil)
                
                expect(subject.rootViewController.presentedViewController).toNot(beNil())
                
                expect(subject.rootViewController.presentedViewController).toEventually(beNil())

                NSNotificationCenter.defaultCenter()
                    .postNotificationName(Constants.signOutNotificationName, object: nil)
            }
            
            xit("shows the login view") {
                expect(subject.rootViewController.presentedViewController).to(beNil())
                
                expect(subject.rootViewController.presentedViewController).toEventuallyNot(beNil())
                
                NSNotificationCenter.defaultCenter()
                    .postNotificationName(Constants.signOutNotificationName, object: nil)
            }
        }
        
    }
}
