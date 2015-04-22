import UIKit

public class SettingsVc: UIViewController {
    @IBOutlet private(set) public weak var emailField: UITextField!
    let settings = Settings(defaults: NSUserDefaults.standardUserDefaults())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEmail()
        self.emailField.becomeFirstResponder()
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
        self.emailField.text = self.settings.email()
    }
    
    private func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
