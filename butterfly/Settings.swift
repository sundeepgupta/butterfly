import UIKit

public struct Settings {
    public static func mailSubject() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let subject = defaults.stringForKey("mailSubject")
        
        return subject ?? ""
    }
    
    public static func saveMailSubject(subject: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(subject, forKey: "mailSubject")
        defaults.synchronize()
    }
    
    public static func reminderTime() -> NSDate {
        let defaults = NSUserDefaults.standardUserDefaults()
        let time = defaults.objectForKey("reminderTime") as? NSDate
        
        return time ?? NSDate()
    }
    
    public static func saveReminderTime(time: NSDate) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(time, forKey: "reminderTime")
        defaults.synchronize()
        
        ScheduleReminder.perform(time)
    }
}
