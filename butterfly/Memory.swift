import Foundation

public struct Memory {
    public static func fromDictionary(dictionary: Dictionary<String, AnyObject>) -> Memory {
        return Memory(thoughts: dictionary["thoughts"] as! String)
    }

    
    let thoughts: String
    
    public init(thoughts: String) {
        self.thoughts = thoughts
    }
    
    
    
    func toDictionary() -> Dictionary<String, AnyObject> {
        return ["thoughts": self.thoughts]
    }
    
}
