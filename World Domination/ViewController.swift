import Cocoa

extension Array{
    
    mutating func shuffled(){
        
        var temp = [Element]()
        
        for _  in self{
            let random = arc4random_uniform(UInt32(self.count))
            let elementTaken = self[Int(random)]
            temp.append(elementTaken)
            self.remove(at: Int(random))
            
        }
        self = temp
    }
}


class ViewController: NSViewController {
    
    @IBOutlet weak var textFieldVerificationCode: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    @IBAction func actionStartPlaying(_ sender: NSButton) {
        
        let code = self.textFieldVerificationCode.stringValue
        
        if self.verificationCode?.count != 6 && self.verificationCode == nil{
            
            if let email = email{
                
                Fetcher.getVerificationCode(email) { (result) in
                    
                
                    print("code is: ",result)
                }

            }else{
                self.dialogOKCancel(question: "Generate Game Code", text: "Please generate a game code using the button below.")
                return
            }
        }
 
        
        func checkNewCode(){
            
            if code == self.verificationCode{
                
                self.performSegue(withIdentifier: NSStoryboardSegue.Identifier.init("StartPlaying"), sender: self)
                self.view.window?.close()
            }else{
                self.dialogOKCancel(question: "Invalid Game Code", text: "Please enter a valid game code. You can generate one using the button below.")
            }
        }
        
        
        if self.verificationCode?.count == 6{
 
            checkNewCode()
            
        }else{
            self.dialogOKCancel(question: "Invalid Game Code", text: "Please enter a valid game code. You can generate one using the button below.")
        }
    }
    @IBAction func generateGamecode(_ sender: NSButton) {
        
        self.view.window?.close()
    }
    
}



