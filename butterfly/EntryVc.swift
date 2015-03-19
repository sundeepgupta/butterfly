import UIKit

class EntryVc: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func save() {
        let postOffice = PostOffice()
        let success = {
            self.statusLabel.text = "Sent!"
        }
        let error = {(errorMessage: String) in
            println(errorMessage)
        }
        postOffice.sendMail("saving message", success: success, failure: error)
    }
}
