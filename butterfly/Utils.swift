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
    
    public static func secretForKey(key: String) -> String {
        let path = NSBundle.mainBundle().pathForResource("Secrets", ofType: "plist")!
        let secrets = NSDictionary(contentsOfFile: path) as! Dictionary<String, String>
        return secrets[key]!
    }
    
    public static func trimWhitespaceFromText(text: String) -> String {
        let spaces = NSCharacterSet.whitespaceCharacterSet()
        return text.stringByTrimmingCharactersInSet(spaces)
    }
}
