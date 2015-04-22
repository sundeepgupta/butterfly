import Foundation

public struct SubmitMemory {
    public static func perform(#thoughts: String, success: (() -> ()), failure: (NSError -> ())) {
        let memory = Memory(thoughts: thoughts)
        StoreMemory(memory: memory, success: success, failure: failure).perform()
        EmailMemory(memory: memory, email: email, success: success, failure: failure).perform()
    }
}
