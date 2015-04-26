import UIKit

public class SettingsVc: UIViewController {
    @IBOutlet private(set) public weak var emailField: UITextField!
    let settings = Settings()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEmail()
        self.emailField.becomeFirstResponder()
    }
    
    @IBAction func save() {
        self.trimWhitespace()
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
    
    private func trimWhitespace() {
        let spaces = NSCharacterSet.whitespaceCharacterSet()
        self.emailField.text = self.emailField.text.stringByTrimmingCharactersInSet(spaces)
    }
    
}
