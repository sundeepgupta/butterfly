import UIKit

public class OldMemoryVc: UIViewController {
    @IBOutlet private(set) public weak var thoughts: UITextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMemory()
    }
    
    // MARK: Private
    private func loadMemory() {
        let success = { (memory: Memory) in
            self.thoughts.text = memory.thoughts
        }
        
        let failure = { (error: NSError) -> Void in
            let alert = Alert.basic(title: "Whoops!", message: "Error showing you an old memory :(\n\n\(error.localizedDescription)")
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        Data.fetchMemory(success: success, failure: failure)
    }
}
