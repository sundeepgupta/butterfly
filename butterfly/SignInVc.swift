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
        
    }
    
}
