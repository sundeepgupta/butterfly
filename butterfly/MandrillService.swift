import Foundation

public class MandrillService {
    let email: String
    let body: String
    
    public init(email: String, body: String) {
        self.email = email
        self.body = body
    }
    
    public func perform(#success: () -> Void, failure: NSError -> Void) {
        let payload = self.payload()
        let request = self.request(payload)
        self.dataTask(request: request, success: success, failure: failure).resume()
    }
    
    
    // MARK: Private
    private func payload() -> Dictionary<String, AnyObject> {
        return [
            "key": Utils.secretForKey("mandrillApiKey"),
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
    
    private func dataTask(#request: NSURLRequest,
        success: () -> Void,
        failure: NSError -> Void) -> NSURLSessionDataTask {
            
            let handler = {(data: NSData!, response: NSURLResponse!, error: NSError!) in
                dispatch_async(dispatch_get_main_queue(), {
                    if error != nil {
                        failure(error)
                        println("Network error saving to Mandrill: \(self.email)\nError: \(error)")
                    } else {
                        let hash = self.convertDataToHash(data)
                        let status = hash["status"] as! String
                        
                        if status == "sent" {
                            success()
                            println("Memory emailed successfully: \(self.email)")
                        } else {
                            let error = self.error(hash: hash)
                            failure(error)
                            println("Error emailing memory: \(self.email)\nError: \(error)")
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

