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
        
        context("Action connections.") {
            it("connects the save button.") {
                let button = subject.navigationItem.rightBarButtonItem
                let selector: Selector = "save"
                
                expect(button?.action).to(equal(selector))
                expect(subject.respondsToSelector(selector)).to(beTrue())
            }
            
            it("connects the cancel button.") {
                let button = subject.navigationItem.leftBarButtonItem
                let selector: Selector = "cancel"
                
                expect(button?.action).to(equal("cancel"))
                expect(subject.respondsToSelector(selector)).to(beTrue())
            }
        }
        
        context("Outlet connections.") {
            it("Connects its outlets.") {
                subject.loadView()
                expect(subject.emailField).toNot(beNil())
            }
        }
    }
}
