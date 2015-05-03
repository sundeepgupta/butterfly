import UIKit

public struct Alert {
    public static func basic(#title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
    
    
    
    
    
    
}
