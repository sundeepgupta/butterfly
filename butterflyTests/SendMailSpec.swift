import Quick
import Nimble
import butterfly

class EmailMemorySpec: QuickSpec {
    override func spec() {
        // These are bad. They actually call out to Mandril and probably are not thread safe.
        // Need to build fakes or wait until Quick/Nimble have better support for doubles.
        
        var successCalled = false
        var failureCalled = false
        let success = { successCalled = true }
        let failure = { (error: NSError) in failureCalled = true }
        
        beforeEach {
            successCalled = false
            failureCalled = false
        }
        
        // Marking pending due to these not working properly
//        xit("Calls success block.") {
//            let email = "well@formed_email.com"
//
//            EmailMemory(email: email, body: "body", success: success, failure: failure).perform()
//            
//            expect(successCalled).toEventually(beTrue(), timeout: 3)
//            expect(failureCalled).toEventually(beFalse(), timeout: 3)
//        }
//        
//        xit("Calls failure block.") {
//            let email = "malformed_email"
//            
//            EmailMemory(email: email, body: "body", success: success, failure: failure).perform()
//            
//            expect(successCalled).toEventually(beFalse(), timeout: 3)
//            expect(failureCalled).toEventually(beTrue(), timeout: 3)
//        }
    }
}