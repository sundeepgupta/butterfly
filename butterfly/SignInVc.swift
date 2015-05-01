import UIKit

public class SignInVc : UIViewController {
    @IBOutlet private(set) public weak var emailField: UITextField!
    @IBOutlet private(set) public weak var passwordField: UITextField!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            self.emailField.text = "sundeepkgupta@gmail.com"
            self.passwordField.text = "somePassword"
        #endif
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.emailField.becomeFirstResponder()
    }
    
    
    @IBAction func signUp() {
        self.emailField.text = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = {
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let errorText = error.userInfo!["error"] as! String
            let message = "There was an error signing up :(\n\n" +
                "\(errorText)"
            Alert(title: "Darn it!", message: message, showIn: self).show()
        }
        
        User.signUp(email: self.emailField.text,
            password: self.passwordField.text,
            success: success,
            failure: failure)
    }
    
    @IBAction func signIn() {
        self.emailField.text = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = {
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let errorText = error.userInfo!["error"] as! String
            let message = "There was an error signing up :(\n\n" +
            "\(errorText)"
            Alert(title: "Darn it!", message: message, showIn: self).show()
        }
        
        User.signIn(email: self.emailField.text,
            password: self.passwordField.text,
            success: success,
            failure: failure)
    }
    
}
