import Quick
import Nimble
import butterfly
import UIKit

class EntryVcSpec: QuickSpec {
    override func spec() {
        var subject: EntryVc!
        
        beforeEach {
            let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            subject = navigationController.viewControllers[0] as! EntryVc
        }
        
        context("IB connections") {
            it("connects the done button") {
                let button = subject.navigationItem.rightBarButtonItem
                let selector: Selector = "submit"
                
                expect(button?.action).to(equal("submit"))
                expect(subject.respondsToSelector(selector)).to(beTrue())
            }
            
            it("connects the settings button") {
                let button = subject.navigationItem.leftBarButtonItem
                expect(button?.action).to(equal("perform:"))
                
                // Don't know how to actually test if the correct VC gets loaded yet so 
                // checking to make sure it's hooked up to a segue at least.
            }
            
            it("connects the text view") {
                subject.loadView()
                expect(subject.textView).toNot(beNil())
            }
        }
        
        context("When handling the keyboard") {
            beforeEach {
                let window = UIWindow(frame: UIScreen.mainScreen().bounds)
                window.rootViewController = subject
                window.makeKeyAndVisible()
            }
            
            it("shows the keyboard when the view appears.") {
                subject.viewWillAppear(false)
                expect(subject.textView.isFirstResponder()).to(beTrue())
            }
            
            it("shrinks the text view height.") {
                subject.loadView()
                let originalHeight = subject.textView.frame.size.height
                
                subject.viewWillAppear(false)
                
                expect(subject.textView.frame.size.height).to(beLessThan(originalHeight))
            }
        }
    }
}
