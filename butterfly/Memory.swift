import UIKit

public class Memory {
    public static func fromDictionary(dictionary: Dictionary<String, AnyObject>) -> Memory {
        return Memory(thoughts: dictionary["thoughts"] as! String)
    }

    
    let thoughts: String
    let photo: UIImage?
    
    public init(thoughts: String, photo: UIImage? = nil) {
        self.thoughts = thoughts
        self.photo = photo
    }
}

public class NullMemory: Memory {
    public init() {
        let thoughts = "Congratulations! You saved your first memory. Tomorrow and every day after that, you'll see a memory you saved in the past"
        super.init(thoughts: thoughts)
    }
}
