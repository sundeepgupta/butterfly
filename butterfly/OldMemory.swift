import Foundation
import Parse

public struct OldMemory {
    let success: Memory -> Void
    let failure: NSError -> Void
    
    public init(success: Memory -> Void, failure: NSError -> Void) {
        self.success = success
        self.failure = failure
    }
    
    public func perform() {
        let query = PFQuery(className: "Memory")
        var error: NSError?
        let remoteObject = query.getFirstObject(&error)
        
        if error != nil {
            self.failure(error!)
            println("Error fetching old memory: \(error)")
        } else {
            let thoughts = remoteObject!["thoughts"] as! String
            let memory = Memory(thoughts: thoughts)
            self.success(memory)
            println("Old memory fetched successfully: \(memory)")
        }
    }
    
    // MARK: Private
}