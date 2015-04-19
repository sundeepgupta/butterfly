import UIKit

public class EntryVc: UIViewController {
    @IBOutlet private(set) public weak var textView: UITextView!
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
    }
    
    @IBAction func submit() {
        let success = {
            Alert(title: "Success!", message: "Your memory was emailed to you :)", showIn: self).show()
        }
        
        let failure = { (error: NSError) -> Void in
            let message = "The email could not be sent.\n\n\(error.userInfo![Keys.errorHash])"
            Alert(title: "Darn it!", message: message, showIn: self).show()
        }
        
        SendMail(email: Settings().email(), body: self.textView.text, success: success, failure: failure).perform()
    }
}
