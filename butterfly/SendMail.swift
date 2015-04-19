import Foundation

public struct SendMail {
    
    public func perform(body: String, success: (() -> ()), failure: (NSError -> ())) {
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: "https://mandrillapp.com/api/1.0/messages/send.json")!
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        let bodyHash = [
            "key": "PyQXIJOBNNN4tpVAWYV5ow",
            "message": [
                "html": "Example HTML content",
                "text": "Example text content",
                "subject": "example subject",
                "from_email": "message.from_email@example.com",
                "from_name": "Example Name",
                "to": ["email": "sundeepkgupta@gmail.com"]
            ]
        ]
        let bodyData = NSJSONSerialization.dataWithJSONObject(bodyHash, options: .PrettyPrinted, error: nil)
        request.HTTPBody = bodyData
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                if error != nil {
                    
                    failure(error)
                } else {
                    let hash = self.convertDataToHash(data)
                    let status = hash["status"] as! String
                    
                    if status == "sent" {
                        success()
                    } else {
                        let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
                        let userInfo: [NSObject: AnyObject] = [Constants.errorHashKey : hash]
                        
                        let error = NSError(domain: appName, code: 1, userInfo: userInfo)
                        failure(error)
                    }
                }
            })
        })
        task.resume()
    }
    
    // MARK: Private
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
}

