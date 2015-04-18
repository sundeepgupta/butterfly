import UIKit

public class EntryVc: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func submit() {
        println("submit")
        let postOffice = PostOffice()
        let success = {
            println("success")
        }
        let error = {(errorMessage: String) in
            println(errorMessage)
        }
        postOffice.sendMail("saving message", success: success, failure: error)
    }
        
}
