import Foundation
import Parse

public struct Data {
    public static func saveMemory(#thoughts: String, success: () -> Void, failure: NSError -> Void) {
        let memory = Memory(thoughts: thoughts)
        var error: NSError?
        self.remoteObjectFromMemory(memory).save(&error)
        
        if error != nil {
            failure(error!)
            println("Error saving memory: \(memory)\nError: \(error)")
        } else {
            success()
            println("Memory saved successfully: \(memory)")
        }
    }
    
    public static func fetchMemory(#success: Memory -> Void, failure: NSError -> Void) {
        var error: NSError?
        let remoteObject: AnyObject? = PFCloud.callFunction("randomMemory", withParameters: nil, error: &error)
        println(remoteObject)
        
        

        if error != nil {
            failure(error!)
            println("Error fetching old memory: \(error)")
        } else {
            let memory = self.memoryFromRemoteObject(remoteObject)
            success(memory)
            println("Old memory fetched successfully: \(memory)")
        }
    }
    
    
    // MARK: Private
    private static func remoteObjectFromMemory(memory: Memory) -> PFObject {
        var dictionary = memory.toDictionary()
        dictionary["user"] = PFUser.currentUser()
        let className = Utils.stringForTypeOfThing(memory)
        return PFObject(className: className, dictionary: dictionary)
    }
    
    private static func memoryFromRemoteObject(remoteObject: AnyObject?) -> Memory {
        let thoughts = remoteObject!["thoughts"] as! String
        return Memory(thoughts: thoughts)
    }
}

