import Foundation
import Parse

public struct ParseMemory: Saveable {
    let memory: Memory
    let parseObject: PFObject
    
    public init(memory: Memory) {
        self.memory = memory
        
        let dictionary = self.memory.toDictionary()
        let className = Utils.stringForTypeOfThing(self.memory)
        self.parseObject = PFObject(className: className, dictionary: dictionary)
    }
    
    public func save(#success: Success, failure: Failure) {
        var error: NSError?
        self.parseObject.save(&error)
        
        if error != nil {
            failure(error!)
            println("Error saving memory to Parse: \(self.parseObject)\nError: \(error)")
        } else {
            success()
            println("Memory stored successfully to Parse: \(self.parseObject)")
        }
    }
}
