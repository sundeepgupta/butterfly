import UIKit

public struct ScheduleReminder {
    
    public static func perform(date: NSDate) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let notification = self.notification(date)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    // MARK: Private
    private static func notification(date: NSDate) -> UILocalNotification {
        var notification = UILocalNotification()
        notification.fireDate = self.reminderDate(date)
        notification.alertTitle = "Don't let that butterly get away!"
        notification.alertBody = "This is your reminder to write your daily memories."
        notification.soundName = UILocalNotificationDefaultSoundName
        return notification
    }
    
    private static func reminderDate(date: NSDate) -> NSDate {
        let now = NSDate()
        if date.earlierDate(now).isEqualToDate(date) {
            let dayInSeconds = 24.0*60.0*60.0
            return date.dateByAddingTimeInterval(dayInSeconds)
        } else {
            return date
        }
    }
}
