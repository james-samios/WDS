import Cocoa


public var email:String?{
    
    set{
        UserDefaults.standard.set(newValue, forKey: "email")
    }
    get{
        return UserDefaults.standard.value(forKey: "email") as? String
    }
}

class GenerateVerificationCode: NSViewController {

    @IBOutlet weak var textFieldEmail: NSTextField!
    @IBOutlet weak var viewProgress: NSBox!
    @IBOutlet weak var activityIndicator: NSProgressIndicator!
    
    private var newCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do view setup here.
    }
    @IBAction func actionSubmit(_ sender: NSButton) {
        
        email = self.textFieldEmail.stringValue
        
        if self.isValidEmail(testStr: email!) == false{
            
            self.dialogOKCancel(question: "Invalid Email", text: "Please enter a valid email address!")
            return
        }

        
        var verficationCode = [1,2,3,4,5,6,7,8,9]
        verficationCode.shuffled()
       
        newCode = ""
        
        for (index,code) in verficationCode.enumerated(){
            
            if index <= 5{
                newCode.append(String(code))
            }
        }
        
        self.showProgress(true)
        
       
        
        let message  = SMTPMessage()
        message.from = "World Domination Simulator"
        message.to = email!
        message.host = "smtp.gmail.com"
        message.account = "wds@samios.io"
        message.pwd = "PS01UbOvvCc1OPzJDsda"
        
        message.subject = "World Domination Simulator | Game Code"
        message.content = "Your game code is: \(newCode). This game code is valid until the simulation is complete. To start again, feel free to press 'reset all progress' in the settings panel, or generate a new game code. This inbox is not monitored, for any issues, please email developer@samios.io. Thanks."
        message.send({ (messg, now, total) in
            
        }, success: { (messg) in
        
            DispatchQueue.main.async {
                self.view.window?.close()
            }
            self.showProgress(false)
            
            
            Fetcher.saveSecurityCode(email!, code: self.newCode) { (result) in
                
                
                self.verificationCode = self.newCode
            }
            
            
            self.dialogOKCancel(question: "Check your inbox", text: "A game code has been sent to your email address.")
        }, failure: { (messg, error) in
            self.showProgress(false)
            print("Error: ",error?.localizedDescription ?? "Unable to send email! Are you connected to the internet?")
        })
    }
    
    override func dismissViewController(_ viewController: NSViewController) {
        super.dismissViewController(viewController)
        
        print("Dismissing")
    }
    
    private func showProgress(_ isShow:Bool){
        
        DispatchQueue.main.async {
            if isShow{
                self.activityIndicator.startAnimation(self)
            }else{
                self.activityIndicator.stopAnimation(self)
            }
            self.viewProgress.isHidden = !isShow
            self.textFieldEmail.isHidden = isShow
        }

    }
    
   
    
}
