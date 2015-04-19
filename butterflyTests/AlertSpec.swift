import Quick
import Nimble
import butterfly
import UIKit

class AlertSpec: QuickSpec {
    override func spec() {
        it("Shows the alert.") {
            let viewController = UIViewController()
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            Alert(title: "Test", message: "Testing", showIn: viewController).show()

            expect(viewController.presentedViewController).toEventuallyNot(beNil())
        }
    }
}
