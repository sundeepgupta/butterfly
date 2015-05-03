import UIKit

public struct VerifyPassword {
    public static func alert(#email: String, success: () -> Void, failure: NSError -> Void) -> UIAlertController {
        var alert = UIAlertController(title: nil, message: "Enter your password:", preferredStyle: .Alert)
        
        let handler = { (action: UIAlertAction!) in
            let textField = alert.textFields!.first as! UITextField
            let password = textField.text
            
            // Parse doesn't give us a better way to verify passwords.
            User.signIn(email: email, password: password, success: success, failure: failure)
        }
        alert.addAction(UIAlertAction(title: "Verify", style: .Default, handler: handler))
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.secureTextEntry = true
        }

        return alert
    }    
}
