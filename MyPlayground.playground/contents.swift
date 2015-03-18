import Foundation

struct PostOffice {
    
    func sendMail() {
        let url = NSURL(string: "https://mandrillapp.com/api/1.0/messages/send.json")!
        let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                println("Error: " + error.localizedDescription)
            } else {
                println("Success")
            }
        
            
        })
        task.resume()
    }
}

let postOffice = PostOffice()
postOffice.sendMail()



