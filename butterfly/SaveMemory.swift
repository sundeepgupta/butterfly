import Foundation

public struct SaveMemory {
    let memory: Saveable
    let success: Success
    let failure: Failure
    
    public init(memory: Saveable, success: Success, failure: Failure) {
        self.memory = memory
        self.success = success
        self.failure = failure
    }
    
    public func perform() {
        self.memory.save(success: self.success, failure: self.failure)
    }
}