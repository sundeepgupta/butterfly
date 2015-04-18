import Foundation

public struct Utils {
    public static func stringForClass(aClass: AnyClass) -> String {
        let nameWithModule = NSStringFromClass(aClass)
        let components = nameWithModule.componentsSeparatedByString(".")
        return components.last!
    }
}
