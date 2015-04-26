import Foundation

public struct MandrillMemory: Saveable {
    let memory: Memory
    let email: String
    
    public init(memory: Memory) {
        self.memory = memory
        self.email = Settings(defaults: NSUserDefaults.standardUserDefaults()).email()
    }
    
    public func save(#success: () -> Void, failure: NSError -> Void) {
        let emailer = MandrillService(email: self.email, body: self.memory.thoughts)
        emailer.perform(success: success, failure: failure)
    }
}
