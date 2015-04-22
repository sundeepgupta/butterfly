import Foundation

public struct EmailMemory {
    let memory: Memory
    let email: String
    let success: (() -> ())
    let failure: (NSError -> ())
    
    public init(memory: Memory, success: (() -> ()), failure: (NSError -> ())) {
        self.memory = memory
        self.email = Settings().email()
        self.success = success
        self.failure = failure
    }
    
    public func perform() {
        let payload = self.payload()
        let request = self.request(payload)
        self.dataTask(request).resume()
    }
    
    // MARK: Private
    private func payload() -> Dictionary<String, AnyObject> {
        return [
            "key": Utils.secretForKey("mandrillApiKey"),
            "message": [
                "text": self.memory.thoughts,
                "subject": "Butterfly Daily Memory",
                "from_email": "no-reply@butterfly.com",
                "from_name": "Butterly",
                "to": [["email": self.email]]
            ]
        ]
    }
    
    private func request(payload: Dictionary<String, AnyObject>) -> NSURLRequest {
        var request = NSMutableURLRequest(URL: NSURL(string: "https://mandrillapp.com/api/1.0/messages/send.json")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(payload, options: .PrettyPrinted, error: nil)
        return request.copy() as! NSURLRequest
    }
    
    private func dataTask(request: NSURLRequest) -> NSURLSessionDataTask {
        let handler = {(data: NSData!, response: NSURLResponse!, error: NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                if error != nil {
                    self.failure(error)
                    println("Network error emailing memory: \(self.memory)\nError: \(error)")
                } else {
                    let hash = self.convertDataToHash(data)
                    let status = hash["status"] as! String
                    
                    if status == "sent" {
                        self.success()
                        println("Memory emailed successfully: \(self.memory)")
                    } else {
                        let error = self.error(hash: hash)
                        self.failure(error)
                        println("Error emailing memory: \(self.memory)\nError: \(error)")
                    }
                }
            })
        }
        
        return NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: handler)
    }
    
    private func convertDataToHash(data: NSData) -> Dictionary<String, AnyObject> {
        let responseObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
        var responseHash = [String: AnyObject]()
        
        if let hash = responseObject as? Dictionary<String, AnyObject> {
            responseHash = hash
        } else if let array = responseObject as? Array<Dictionary<String, AnyObject>> {
            responseHash = array.first!
        } else {
            println("Unkown data type: " + data.description)
        }
        
        return responseHash
    }
    
    private func error(#hash: Dictionary<String, AnyObject>) -> NSError {
        let userInfo: [NSObject: AnyObject] = [Keys.errorHash : hash]
        return NSError(domain: Utils.appName(), code: 42, userInfo: userInfo)
    }
}

