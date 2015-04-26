import Foundation

public class SubmitMemory : NSObject {
    let memory: Memory
    let success: () -> Void
    let failure: NSError -> Void
    
    public init(factory: SaveableFactory,
        memory: Memory,
        success: () -> Void,
        failure: NSError -> ()) {
        
            self.memory = memory
    //        self.email = email
            self.success = success
            self.failure = failure
    }
    
    public func perform(#thoughts: String, success: () -> Void, failure: (NSError) -> Void) {

    }
}
