import UIKit

public class SettingsVc: UIViewController {
    @IBOutlet public weak var emailField: UITextField!
    let settings = Settings()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEmail()
    }
    
    @IBAction func save() {
        self.settings.saveEmail(self.emailField.text)
        self.dismiss()
    }
    
    @IBAction func cancel() {
        self.dismiss()
    }
    
    // MARK: Private
    private func loadEmail() {
        #if DEBUG
            self.emailField.text = "sundeep@sundeepgupta.ca"
        #else
            self.emailField.text = self.settings.email()
        #endif
    }
    
    private func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
