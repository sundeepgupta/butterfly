import UIKit

protocol PickPhotoDelegate: class {
    func pickedPhoto(photo: UIImage)
}

//public typedef

public class PickPhoto: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let viewController: UIViewController
    private weak var delegate: PickPhotoDelegate?
    private var picker = UIImagePickerController()
    
    
    init(showIn viewController: UIViewController, delegate: PickPhotoDelegate) {
        self.viewController = viewController
        self.delegate = delegate
        super.init()
        self.picker.delegate = self
    }
    
    public func show() {
        self.viewController.presentViewController(self.picker, animated: true, completion: nil)
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let photo: AnyObject? = info[UIImagePickerControllerOriginalImage]
        self.delegate?.pickedPhoto(photo as! UIImage)
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
