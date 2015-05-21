import UIKit

public class NewMemory : UIViewController {
    @IBOutlet private weak var thoughtsField: UITextView!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustTextViewHeight:", name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.thoughtsField.becomeFirstResponder()
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let addPhotoVc = segue.destinationViewController as! AddPhotoVc
        addPhotoVc.thoughts = self.thoughtsField.text
    }
    
    func adjustTextViewHeight(notification: NSNotification) {
        let frameInfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardEndY = frameInfo.CGRectValue().origin.y
        self.bottomConstraint.constant = self.view.frame.size.height - keyboardEndY
        self.view.layoutIfNeeded()
    }
    
}
