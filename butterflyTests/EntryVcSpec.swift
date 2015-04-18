import Quick
import Nimble
import butterfly

class EntryVcSpec: QuickSpec {
    

    
    override func spec() {
        it("saves the memory") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let subject = navigationController.viewControllers[0] as! EntryVc
            
            let doneButton = subject.navigationItem.rightBarButtonItem
            let selector = doneButton?.action
            
            expect(selector).to(equal("save:"))
        }
    }
}
