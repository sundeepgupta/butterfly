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
        
        self.scheduleNotification(time)
    }
    
    
    // MARK: Private
    private static func scheduleNotification(date: NSDate) {
        var notification = UILocalNotification()
        
        if date.earlierDate(NSDate()).isEqualToDate(date) {
            let futureDate = date.dateByAddingTimeInterval(24*60*60)
            notification.fireDate = futureDate
        } else {
            notification.fireDate = date
        }

        notification.alertTitle = "Don't let that butterly get away!"
        notification.alertBody = "This is your reminder to write your daily memories."
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
