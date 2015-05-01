import UIKit

public class NewMemory : UIViewController {
    @IBOutlet private(set) public weak var thoughts: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "adjustTextViewHeight:",
            name: UIKeyboardDidChangeFrameNotification,
            object: nil)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.thoughts.becomeFirstResponder()
    }
    
    @IBAction func submit() {
        let success = {
            self.performSegueWithIdentifier("toOldMemory", sender: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let message = "There was an error saving your memory :(\n\n" +
                "\(error.userInfo![Keys.errorHash])"
            Alert(title: "Darn it!", message: message, showIn: self).show()
        }
        
        Data.saveMemory(thoughts: self.thoughts.text, success: success, failure: failure)
    }
    
    func adjustTextViewHeight(notification: NSNotification) {
        let frameInfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardEndY = frameInfo.CGRectValue().origin.y
        self.bottomConstraint.constant = self.view.frame.size.height - keyboardEndY
        self.view.layoutIfNeeded()
    }
}