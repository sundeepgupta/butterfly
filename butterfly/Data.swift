import Parse

public struct Data {
    public static func saveMemory(#thoughts: String, photo: UIImage?, success: () -> Void, failure: NSError -> Void) {
        let memory = Memory(thoughts: thoughts, photo: photo)
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
        var remoteObject = PFObject(className: Utils.stringForTypeOfThing(memory))
        remoteObject["user"] = PFUser.currentUser()
        remoteObject["thoughts"] = memory.thoughts
        
        if let photo = memory.photo {
            remoteObject["photo"] = self.remotePhoto(photo)
        }
        
        return remoteObject
    }
    
    private static func remotePhoto(photo: UIImage) -> PFFile {
        let photoData = UIImageJPEGRepresentation(photo, 1)
        return PFFile(data: photoData, contentType: "image/jpeg")
    }
    
    private static func memoryFromRemoteObject(remoteObject: AnyObject?) -> Memory {
        if let object: AnyObject = remoteObject {
            let thoughts = object["thoughts"] as! String
            let photo = self.fetchPhoto(object)
            return Memory(thoughts: thoughts, photo: photo)
        } else {
            return NullMemory()
        }
    }
    
    private static func fetchPhoto(object: AnyObject) -> UIImage? {
        if let file = object["photo"] as? PFFile {
            let data = file.getData()
            return UIImage(data: data!)
        } else {
            return nil
        }
    }
}
