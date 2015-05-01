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
        
        let failure = { (error: NSError) in
            Alert(title: "Whoops!",
                message: "Error showing you an old memory :(\n\n\(error.localizedDescription)",
                showIn: self).show()
        }
        
        OldMemory(success: success, failure: failure).perform()
    }
}
