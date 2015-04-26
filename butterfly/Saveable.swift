import Foundation

public protocol Saveable {
    let memory: Memory
    
    init(memory: Memory)
    func save(#success: () -> Void, failure: NSError -> Void)
}

