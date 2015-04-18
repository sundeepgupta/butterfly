import Quick
import Nimble
import butterfly

class SettingsVcSpec: QuickSpec {
    override func spec() {
        var subject: SettingsVc!
        
        beforeEach {
            let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
            let name = Utils.stringForClass(SettingsVc)
            subject = storyboard.instantiateViewControllerWithIdentifier(name) as! SettingsVc
        }
        
        context("IB connections.") {
            it("Connects the save button.") {
                let button = subject.navigationItem.rightBarButtonItem
                let selector: Selector = "save"
                
                expect(button?.action).to(equal(selector))
                expect(subject.respondsToSelector(selector)).to(beTrue())
            }
            
            it("Connects the cancel button.") {
                let button = subject.navigationItem.leftBarButtonItem
                let selector: Selector = "cancel"
                
                expect(button?.action).to(equal("cancel"))
                expect(subject.respondsToSelector(selector)).to(beTrue())
            }
            
            it("Connects its outlets.") {
                subject.loadView()
                expect(subject.emailField).toNot(beNil())
            }
        }
        
        context("Email") {
            it("Renders the currently configured email") {
                let email = "some@email.com"
                Settings().saveEmail(email)
                
                subject.loadView()
                subject.viewDidLoad()
                
                expect(subject.emailField.text).to(equal(email))
            }
        }
        
        
    }
}
