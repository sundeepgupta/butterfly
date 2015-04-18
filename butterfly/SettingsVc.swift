import UIKit

public class SettingsVc: UIViewController {
    @IBOutlet public weak var emailField: UITextField!
    let settings = Settings()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.text = self.settings.email()
    }
    
    
    @IBAction func save() {
        
    }
    
    @IBAction func cancel() {
        
    }
    
}
