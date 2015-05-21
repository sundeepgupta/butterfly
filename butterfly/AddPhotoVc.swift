import UIKit

public class AddPhotoVc : UIViewController, PickPhotoDelegate {
    var thoughts = ""
    @IBOutlet weak var photoView: UIImageView!
    lazy var pickPhoto: PickPhoto = PickPhoto(showIn: self, delegate: self)

    
    @IBAction func add() {
        self.pickPhoto.show()
    }
    
    @IBAction func remove() {
        self.photoView.image = nil
    }
    
    public override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        var shouldPerform = false
        
        let success = { () -> Void in
            shouldPerform = true
        }
        
        let failure = { (error: NSError) -> Void in
            let errorMessage = error.userInfo!["error"] as! String
            let message = "There was an error saving your memory :(\n\n\(errorMessage)"
            let alert =  Alert.basic(title: "Darn!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        Data.saveMemory(thoughts: self.thoughts, photo: self.photoView.image, success: success, failure: failure)
        
        return shouldPerform
    }
    
    // MARK: AddPhotoDelegate
    func pickedPhoto(photo: UIImage) {
        self.photoView.image = photo
    }
}
