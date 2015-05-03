import UIKit

public typealias Verify = (email: String, password: String, success: () -> Void, failure: NSError -> Void) -> Void

public class VerifyPassword: NSObject, UITextFieldDelegate {
    
    
    
    
    var alert: UIAlertController = UIAlertController(title: "", message: "Enter your current password:", preferredStyle: .Alert)
    
    
    
    
    public init(email: String, success: () -> Void, failure: NSError -> Void) {
        super.init()
        
        let handler = { (action: UIAlertAction!) -> Void in
            let textField = self.alert.textFields!.first as! UITextField
            let password = textField.text
            
            // We shouldn't really sign in again, but Parse doesn't give us a better way. 
            User.signIn(email: email, password: password, success: success, failure: failure)
        }
        
        let action = UIAlertAction(title: "Verify", style: UIAlertActionStyle.Default, handler: handler)
        self.alert.addAction(action)
        self.alert.addTextFieldWithConfigurationHandler { (textField) in return }
    }
    
    
    
}
