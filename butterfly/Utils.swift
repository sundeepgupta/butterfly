import Foundation

public struct Utils {
    public static func stringForClass(aClass: AnyClass) -> String {
        let nameWithModule = NSStringFromClass(aClass)
        let components = nameWithModule.componentsSeparatedByString(".")
        return components.last!
    }
    
    public static func appName() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
    }
    
//    public static func mangledSelector:(selector: Selector) -> Selector {
//        
//    }
}
