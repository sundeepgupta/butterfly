import Foundation

public struct SubmitMemory {
    public static func perform(#thoughts: String, success: (() -> ()), failure: (NSError -> ())) {
        let memory = Memory(thoughts: thoughts)
        let email = Settings(defaults: NSUserDefaults.standardUserDefaults()).email()
        EmailMemory(memory: memory, email: email, success: success, failure: failure).perform()

        let parseMemory = ParseMemory(memory: memory)
        SaveMemory(memory: parseMemory, success: success, failure: failure).perform()
    }
}
