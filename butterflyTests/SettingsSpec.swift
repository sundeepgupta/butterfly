import Quick
import Nimble
import butterfly

class SettingsSpec: QuickSpec {
    override func spec() {
        var subject = Settings()
        var defaults = NSUserDefaults.standardUserDefaults()
        
        beforeEach {
            subject = Settings()
            
            let domain = NSBundle.mainBundle().bundleIdentifier
            defaults.removePersistentDomainForName(domain!)
        }
        
        it("saves the email setting") {
            let email = "bla@blabla.com"
            subject.saveEmail(email)
            expect(defaults.stringForKey(Constants.emailKey)).to(equal(email))
        }
        
        it("provides the email setting after one has been saved") {
            let email = "bla@blabla.com"
            subject.saveEmail(email)
            expect(subject.email()).to(equal(email))
        }
        
        it("provides an empty email when none has been saved") {
            expect(subject.email()).to(equal(""))
        }
    }
}
