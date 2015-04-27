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
            let message = "There was an error signing up:(\n\n" +
                "\(error.userInfo![Keys.errorHash])"
            Alert(title: "Darn it!", message: message, showIn: self).show()
        }
        
        let signUp = SignUp(email: self.emailField.text,
            password: self.passwordField.text,
            success: success,
            failure: failure)
        signUp.perform()
    }
    
}
