import UIKit

public class EntryVc: UIViewController {
    @IBOutlet private(set) public weak var textView: UITextView!
    
    @IBAction func submit() {
        let success = {
            println("success")
        }
        
        let error = {(errorMessage: String) in
            println(errorMessage)
        }
        
        SendMail().perform(self.textView.text, success: success, failure: error)
    }
        
}
