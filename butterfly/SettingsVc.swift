import UIKit

public class SettingsVc : UIViewController {
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSettings()
    }
    
    @IBAction func updateCredentials() {
        // If user changes their email before pressing this button, is that ok?
        
        let success = { () -> Void in
            self.emailField.enabled = true
            self.passwordField.enabled = true
        }
        
        let failure = { (error: NSError) -> Void in
            let message = "Your password could not be verified."
            let alert = Alert.basic(title: "Whoops!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }

        let alert = Alert.password(email: self.emailField.text, success: success, failure: failure)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func save() {
        let email = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = {
            self.dismiss()
        }
        
        let failure = { (error: NSError) -> Void in
            let alert = Alert.basic(title: "Whoops!", message: "Error updating email :(\n\n\(error.localizedDescription)")
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        User.updateEmail(email, success: success, failure: failure)
    }
    
    @IBAction func cancel() {
        self.dismiss()
    }
    
    @IBAction func signOut() {
        User.signOut()
    }
    
    
    
    
    
    // MARK: Private
    private func loadSettings() {
        self.emailField.text = User.email()
    }
    
    private func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
