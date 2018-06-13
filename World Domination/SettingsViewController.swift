import Cocoa
import LocalAuthentication
class SettingsViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func actionResetAllProgress(_ sender: NSButton) {
        
        let myContext = LAContext()
        let myLocalizedReasonString = "reset your progress"
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.2, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        
                        self.dialogOKCancel(question: "Your progress has been reset successfully!", text: "To play again, generate a new game code.")
                        self.verificationCode = nil
                        
                        if let email = email{
                            
                            Fetcher.clearUser(email, completion: { (result) in
                                print("User Deleted:", result)
                            })
                        }
                        
                    } else {
                        
                    }
                }
            } else {
                
            }
        } else {
            
        }
    }
    
}
