import UIKit

public class SettingsVc : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var reminderTimeButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timePickerBottom: NSLayoutConstraint!
    private let formatTime = FormatTime()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSettings()
        self.hideTimePicker()
    }
    
    @IBAction func updateCredentials() {
        let success = { () -> Void in
            self.performSegueWithIdentifier("toUpdateCredentials", sender: nil)
        }
        
        let failure = { (error: NSError) -> Void in
            let message = "Your password could not be verified."
            let alert = Alert.basic(title: "Whoops!", message: message)
            self.presentViewController(alert, animated: true, completion: nil)
        }

        let alert = Alert.password(email: User.email(), success: success, failure: failure)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func setReminderTime() {
        self.showTimePicker()
    }
    
    @IBAction func reminderTimeChanged() {
        let time = self.formatTime.fromDate(self.timePicker.date)
        self.reminderTimeButton.setTitle(time, forState: .Normal)
    }
    
    @IBAction func save() {
        Settings.saveMailSubject(self.subjectField.text)
        Settings.saveReminderTime(self.timePicker.date)
        self.dismiss()
    }
    
    @IBAction func cancel() {
        self.dismiss()
    }
    
    @IBAction func signOut() {
        User.signOut()
    }
    
    public override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return false
        // We want to manually perform the segue.
    }
    
    
    //MARK: UITextFieldDelegate
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    // MARK: Private
    private func loadSettings() {
        self.subjectField.text = Settings.mailSubject()
        self.loadReminderTime()
    }
    
    private func loadReminderTime() {
        let time = Settings.reminderTime()
        self.timePicker.date = time
        let timeString = self.formatTime.fromDate(time)
        self.reminderTimeButton.setTitle(timeString, forState: .Normal)
    }
    
    private func hideTimePicker() {
        self.timePickerBottom.constant = -(self.timePicker.frame.size.height)
    }
    
    private func showTimePicker() {
        self.timePickerBottom.constant = 0
    }
    
    private func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
