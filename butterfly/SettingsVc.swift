import UIKit

public class SettingsVc : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var subjectField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSettings()
    }
    
    @IBAction func updateCredentials() {
        let success = { () -> Void in
            self.performSegueWithIdentifier("toUpdateCredentials", sender: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let message = "Your password could not be verified."
            let alert = Alert.basic(title: "Whoops!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }

        let alert = Alert.password(email: User.email(), success: success, failure: failure)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func save() {
        Settings.saveMailSubject(self.subjectField.text)
        self.dismiss()
    }
    
    @IBAction func cancel() {
        self.dismiss()
    }
    
    @IBAction func signOut() {
        User.signOut()
    }
    
    public override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return false
        // We want to manually perform the segue.
    }
    
    
    //MARK: UITextFieldDelegate
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    // MARK: Private
    private func loadSettings() {
        self.subjectField.text = Settings.mailSubject()
    }
    
    private func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
