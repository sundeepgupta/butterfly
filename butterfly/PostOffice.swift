import Foundation

struct PostOffice {
    
    func sendMail() {
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
                "to": [
                    [
                    "email": "recipient.email@example.com",
                    "name": "Recipient Name",
                    "type": "to"
                    ]
                ]
            ]
        ]
        let bodyData = NSJSONSerialization.dataWithJSONObject(bodyHash, options: .PrettyPrinted, error: nil)
        request.HTTPBody = bodyData
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if error != nil {
                println("NSURLSession Error: " + error.localizedDescription)
            } else {
                println("Response: " + response.description)
                
                let responseObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                let responseArray = responseObject as! Array<Dictionary<String, AnyObject>>
                let responseHash = responseArray.first!
                println("Data: \(responseHash)")
            }
        })
        task.resume()
    }
}