import Foundation

public struct Utils {
    public static func stringForClass(aClass: AnyClass) -> String {
        let nameWithModule = NSStringFromClass(aClass)
        let components = nameWithModule.componentsSeparatedByString(".")
        return components.last!
    }
    
    public static func stringForTypeOfThing(thing: Any) -> String {
        let type = _stdlib_getDemangledTypeName(thing)
        let components = type.componentsSeparatedByString(".")
        return components.last!
    }
    
    public static func appName() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
    }
}
