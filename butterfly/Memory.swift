import Foundation

public class Memory {
    public static func fromDictionary(dictionary: Dictionary<String, AnyObject>) -> Memory {
        return Memory(thoughts: dictionary["thoughts"] as! String)
    }

    
    let thoughts: String
    
    public init(thoughts: String) {
        self.thoughts = thoughts
    }
    
    public func toDictionary() -> Dictionary<String, AnyObject> {
        return ["thoughts": self.thoughts]
    }
}

public class NullMemory: Memory {
    public init() {
        let thoughts = "Congratulations! You saved your first memory. Tomorrow and every day after that, you'll see a memory you saved in the past"
        super.init(thoughts: thoughts)
    }
}
