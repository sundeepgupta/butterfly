import UIKit

public class OldMemoryVc: UIViewController {
    @IBOutlet private weak var thoughts: UITextView!
    @IBOutlet private weak var photoView: UIImageView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMemory()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    
    // MARK: Private
    private func loadMemory() {
        let success = { (memory: Memory) -> Void in
            self.thoughts.text = memory.thoughts
            self.photoView.image = memory.photo
        }
        
        let failure = { (error: NSError) -> Void in
            let alert = Alert.basic(title: "Whoops!", message: "Error showing you an old memory :(\n\n\(error.localizedDescription)")
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        Data.fetchMemory(success: success, failure: failure)
    }
}
