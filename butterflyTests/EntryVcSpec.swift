import Quick
import Nimble
import butterfly

class EntryVcSpec: QuickSpec {
    override func spec() {
        var subject: EntryVc!
        
        beforeEach {
            let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            subject = navigationController.viewControllers[0] as! EntryVc
        }
        
        context("Action connections") {
            it("connects the done button") {
                let button = subject.navigationItem.rightBarButtonItem
                expect(button?.action).to(equal("submit"))
            }
            
            it("connects the settings button") {
                let button = subject.navigationItem.leftBarButtonItem
                expect(button?.action).to(equal("perform:"))
                
                // Don't know how to actually test if the correct VC gets loaded yet so 
                // checking to make sure it's hooked up to a segue at least.
            }
        }
    }
}
