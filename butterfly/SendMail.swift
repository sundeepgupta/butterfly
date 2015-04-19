import Foundation

public struct SendMail {
    let email: String
    let body: String
    let success: (() -> ())
    let failure: (NSError -> ())
    
    public init(email: String, body: String, success: (() -> ()), failure: (NSError -> ())) {
        self.email = email
        self.body = body
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
            "key": "PyQXIJOBNNN4tpVAWYV5ow",
            "message": [
                "text": self.body,
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
                } else {
                    let hash = self.convertDataToHash(data)
                    let status = hash["status"] as! String
                    
                    if status == "sent" {
                        self.success()
                    } else {
                        self.failure(self.error(hash))
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
        println("Email request's response hash: \(responseHash)")
        
        return responseHash
    }
    
    private func error(hash: Dictionary<String, AnyObject>) -> NSError {
        let userInfo: [NSObject: AnyObject] = [Keys.errorHash : hash]
        return NSError(domain: Utils.appName(), code: 42, userInfo: userInfo)
    }
}

