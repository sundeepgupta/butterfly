import Foundation
import Parse

public struct StoreMemory {
    private let memory: Memory
    let success: (() -> ())
    let failure: (NSError -> ())
    
    public init(memory: Memory, success: (() -> ()), failure: (NSError -> ())) {
        self.memory = memory
        self.success = success
        self.failure = failure
    }
    
    public func perform() {
        var error: NSError?
        self.remoteObject().save(&error)
        
        if error != nil {
            self.failure(error!)
            println("Error storing memory: \(self.memory)\nError: \(error)")
        } else {
            self.success()
            println("Memory stored successfully: \(self.memory)")
        }
    }
    
    // MARK: Private
    private func remoteObject() -> PFObject {
        let dictionary = self.memory.toDictionary()
        let className = Utils.stringForTypeOfThing(self.memory)
        return PFObject(className: className, dictionary: dictionary)
    }
}