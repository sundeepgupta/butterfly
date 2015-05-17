import Foundation

public struct FormatTime {
    var formatter = NSDateFormatter()
    
    public init() {
        self.formatter.timeStyle = .ShortStyle
    }
    
    public func fromDate(date: NSDate) -> String {
        return self.formatter.stringFromDate(date)
    }
}
