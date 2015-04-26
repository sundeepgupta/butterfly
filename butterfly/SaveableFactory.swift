import Foundation

public protocol SaveableFactory {
    func create(memory: Memory) -> Saveable
}

public struct ParseSaveableFactory : SaveableFactory {
    public func create(memory: Memory) -> Saveable {
        return ParseMemory(memory: memory)
    }
}
