import Foundation
import Cocoa

extension NSViewController{
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func dialogOKCancel(question: String, text: String){
        
        DispatchQueue.main.async {
            let alert: NSAlert = NSAlert()
            alert.messageText = question
            alert.informativeText = text
            alert.alertStyle = NSAlert.Style.informational
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    public var verificationCode:String?{
        
        get{
            
            return UserDefaults.standard.value(forKey: "verification-code") as? String
        }
        
        set{
            
            UserDefaults.standard.set(newValue, forKey: "verification-code")
        }
    }
    
}
