import UIKit

public class SettingsVc : UIViewController {
    @IBOutlet private(set) weak var emailField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSettings()
    }
    
    
    // MARK: IBActions
    @IBAction func updatePassword() {
        // If user changes their email before pressing this button, is that ok?
        
        let success = {
            println("success")
            // let them change their password now (and probably email too)
        }
        
        let failure = { (error: NSError) in
            println("Password verification failed with error: \(error.localizedDescription)")
        }

        let verify = VerifyPassword.alert(email: self.emailField.text, success: success, failure: failure)
        self.presentViewController(verify, animated: true, completion: nil)
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
