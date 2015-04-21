import Foundation

public struct Memory {
    let thoughts: String
    
    public init(thoughts: String) {
        self.thoughts = thoughts
    }
    
    func toDictionary() -> Dictionary<String, AnyObject> {
        return ["thoughts": self.thoughts]
    }
    
    public func toJson() -> String {
        return NSString(data: self.toJsonData(), encoding: NSUTF8StringEncoding) as! String
    }
    
    // MARK: Private
    private func toJsonData() -> NSData {
        var error: NSError?
        let data = NSJSONSerialization.dataWithJSONObject(self.toDictionary(), options: nil, error: &error)
        if data != nil {
            return data!
        } else {
            println("Serialization failed with error: \(error?.localizedDescription)")
            abort()
        }
    }
}
