import UIKit

public class EntryVc: UIViewController {
    @IBOutlet private(set) public weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustTextViewHeight:", name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
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
        
        EmailMemory(email: Settings().email(), body: self.textView.text, success: success, failure: failure).perform()
    }
    
    // MARK: UIKeyboardDidChangeFrameNotification
    func adjustTextViewHeight(notification: NSNotification) {
        let frameInfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardEndY = frameInfo.CGRectValue().origin.y
        self.bottomConstraint.constant = self.view.frame.size.height - keyboardEndY
        self.view.layoutIfNeeded()
    }
}
