import UIKit

public class SignInVc : UIViewController {
    @IBOutlet private(set) public weak var emailField: UITextField!
    @IBOutlet private(set) public weak var passwordField: UITextField!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            self.emailField.text = "sundeepkgupta@gmail.com"
            self.passwordField.text = "bla"
        #endif
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.emailField.becomeFirstResponder()
    }
    
    
    @IBAction func signUp() {
        self.emailField.text = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = {
            self.signIn()
        }
        
        let failure = { (error: NSError) -> Void in
            let errorText = error.userInfo!["error"] as! String
            let message = "There was an error signing up :(\n\n\(errorText)"
            let alert = Alert.basic(title: "Darn!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        User.signUp(email: self.emailField.text,
            password: self.passwordField.text,
            success: success,
            failure: failure)
    }
    
    @IBAction func signIn() {
        self.emailField.text = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = { () -> Void in
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
            self.promptForNotifications()
        }
        
        let failure = { (error: NSError) -> Void in
            let errorText = error.userInfo!["error"] as! String
            let message = "There was an error signing up :(\n\n" +
            "\(errorText)"
            let alert = Alert.basic(title: "Darn!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        User.signIn(email: self.emailField.text, password: self.passwordField.text, success: success, failure: failure)
    }
    
    @IBAction func resetPassword() {
        self.emailField.text = Utils.trimWhitespaceFromText(self.emailField.text)
        
        let success = { () -> Void in
            let alert = Alert.basic(title: "Password reset requested", message: "Check your email to complete the process.")
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let errorText = error.userInfo!["error"] as! String
            let message = "There was an error resetting your password :(\n\n" +
            "\(errorText)"
            let alert = Alert.basic(title: "Darn!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        User.resetPassword(email: self.emailField.text, success: success, failure: failure)
    }
    
    
    // MARK: Private
    private func promptForNotifications() {
        let types: UIUserNotificationType = .Sound | .Alert
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
}
