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
            println("subject")
        }
        
        context("Action connections") {
            it("connects the save button") {
                let button = subject.navigationItem.rightBarButtonItem
                expect(button?.action).to(equal("save"))
            }
            
            it("connects the cancel button") {
                let button = subject.navigationItem.leftBarButtonItem
                expect(button?.action).to(equal("cancel"))
            }
        }
    }
}
