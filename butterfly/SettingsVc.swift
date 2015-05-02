import UIKit

public class SettingsVc : UIViewController {
    @IBOutlet private(set) weak var emailField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSettings()
    }
    
    
    // MARK: IBActions
    @IBAction func updatePassword() {
        
    }
    
    @IBAction func save() {
        let email = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = {
            self.dismiss()
        }
        
        let failure = { (error: NSError) in
            Alert.showBasic(title: "Whoops!", message: "Error updating email :(\n\n\(error.localizedDescription)", viewController: self)
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
