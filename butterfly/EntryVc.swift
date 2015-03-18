import UIKit

class EntryVc: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func save() {
        let postOffice = PostOffice()
        postOffice.sendMail()
    }
}
