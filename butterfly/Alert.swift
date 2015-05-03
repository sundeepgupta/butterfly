import UIKit

public struct Alert {
    public static func basic(#title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
    
    public static func password(#email: String, success: () -> Void, failure: NSError -> Void) -> UIAlertController {
        var alert = UIAlertController(title: nil, message: "Enter your password:", preferredStyle: .Alert)
        
        let handler = { (action: UIAlertAction!) -> Void in
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
