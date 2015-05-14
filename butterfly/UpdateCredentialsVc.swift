import UIKit

public class UpdateCredentialsVc: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCredentials()
    }
    
    @IBAction func save(sender: AnyObject) {
        let email = Utils.trimWhitespaceFromText(self.emailField.text)
        let password = self.passwordField.text
        
        let success = { () -> Void in
            self.navigationController!.popViewControllerAnimated(true)
        }
        
        let failure = { (error: NSError) -> Void in
            let alert = Alert.basic(title: "Whoops!", message: "Error updating email :(\n\n\(error.localizedDescription)")
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        User.updateCredentials(email: email, password: password, success: success, failure: failure)
    }

    
    //MARK: Private
    private func loadCredentials() {
        self.emailField.text = User.email()
    }
}