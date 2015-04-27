import Quick
import Nimble
import butterfly
import UIKit

class SignInVcSpec: QuickSpec {
    override func spec() {
        var subject: SignInVc!
        
        beforeEach {
            let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
            let name = Utils.stringForClass(SignInVc)
            subject = storyboard.instantiateViewControllerWithIdentifier(name) as! SignInVc
        }
        
        context("IB connections") {
            beforeEach {
                subject.loadView()
            }
            
            it("connects the email field") {
                expect(subject.emailField).toNot(beNil())
            }
            
            it("connects the password field") {
                expect(subject.passwordField).toNot(beNil())
            }
        }
        
        it("shows the keyboard when the view appears.") {
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = subject
            window.makeKeyAndVisible()
            
            subject.viewWillAppear(false)
            
            expect(subject.emailField.isFirstResponder()).to(beTrue())
        }
    }
}
