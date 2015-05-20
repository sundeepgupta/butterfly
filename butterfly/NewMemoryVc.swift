import UIKit

public class NewMemory : UIViewController, PickPhotoDelegate {
    @IBOutlet weak var thoughts: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoView: UIImageView!
    lazy var pickPhoto: PickPhoto = PickPhoto(showIn: self, delegate: self)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustTextViewHeight:", name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.thoughts.becomeFirstResponder()
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @IBAction func addPhoto() {
        self.pickPhoto.show()
    }
    
    @IBAction func submit() {
        let success = {
            self.performSegueWithIdentifier("toOldMemory", sender: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let errorMessage = error.userInfo!["error"] as! String
            let message = "There was an error saving your memory :(\n\n\(errorMessage)"
            let alert =  Alert.basic(title: "Darn!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        Data.saveMemory(thoughts: self.thoughts.text, photo: self.photoView.image, success: success, failure: failure)
    }
    
    func adjustTextViewHeight(notification: NSNotification) {
        let frameInfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardEndY = frameInfo.CGRectValue().origin.y
        self.bottomConstraint.constant = self.view.frame.size.height - keyboardEndY
        self.view.layoutIfNeeded()
    }
    
    // MARK: AddPhotoDelegate
    func pickedPhoto(photo: UIImage) {
        self.photoView.image = photo
    }
}
