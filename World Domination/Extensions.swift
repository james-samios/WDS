import Foundation
import Cocoa

extension NSViewController{
    
    
    public var balance:Int64{
        
        set{
            
            UserDefaults.standard.set(newValue, forKey: "com.balance")
        }
        
        get{
           
            if let amount = UserDefaults.standard.value(forKey: "com.balance") as? Int64{
                return amount
            }else{
                return 5000
            }
        }
    }
    
    public var purchasedItems:[String:Int]!{
        
        set{
            
            UserDefaults.standard.set(newValue, forKey: "com.purchased")
        }
        
        get{
            
            if let items = UserDefaults.standard.value(forKey: "com.purchased") as? [String:Int]{
                return items
            }else{
                let items = [String:Int]()
                return items
                
            }
        }
        
    }
    
    public var selledItems:[String:Int]!{
        
        set{
            
            UserDefaults.standard.set(newValue, forKey: "com.selled")
        }
        
        get{
            
            if let items = UserDefaults.standard.value(forKey: "com.selled") as? [String:Int]{
                return items
            }else{
                let items = [String:Int]()
                return items
                
            }
        }
    }
    
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
