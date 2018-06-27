import Cocoa

class PurchaseItemsVC: NSViewController {

    @IBOutlet weak var checkBox1: NSButton!
    @IBOutlet weak var checkBox2: NSButton!
    
    public var items = [String:Int]()
    
    var price = [Int]()
    
    public var mainVC:Main!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for (offset: index,element: (key: key,value: value)) in self.items.enumerated(){
            if index == 0{
                self.checkBox1.title  = key + " ($\(String(value)))"
                self.checkBox1.tag = value
            }else{
                self.checkBox2.title  = key + " ($\(String(value)))"
                self.checkBox2.tag = value
            }
            self.price.append(value)
        }

    }

    
    @IBAction func actionPurchase(_ sender: Any) {
        
        var amount = 0
        
        var purchase = [String:Int]()
        
        if self.checkBox1.state == .on{
            
            amount += self.checkBox1.tag
            
            purchase.updateValue(self.checkBox1.tag, forKey:self.checkBox1.title )
        }
        
        if self.checkBox2.state == .on{
            
            amount += self.checkBox2.tag
            
            purchase.updateValue(self.checkBox2.tag, forKey: self.checkBox2.title)

        }
        
        if self.balance >= amount{
            
            self.balance = self.balance-Int64(amount)
            self.mainVC.labelBalance.stringValue = "$"+(String(self.balance))
            
            for (key,value) in self.purchasedItems{
                
                purchase.updateValue(value, forKey: key)
            }
            
            self.purchasedItems = purchase
            
            self.mainVC.labelOpenOrderCount.stringValue = String(self.purchasedItems.count)
            
            
        }else{
            self.showModel(question: "Insufficient Balance", text: "Please complete open orders to purchase this item!", buttonTitle: "Ok")
        }
        
    }
    
    
    @IBAction func actionSell(_ sender: NSButton) {
        
        var amount = 0

        var selled = [String:Int]()
        
        if self.checkBox1.state == .on{

            amount += self.checkBox1.tag
            
            selled.updateValue(self.checkBox1.tag, forKey: self.checkBox1.title)
        }

        if self.checkBox2.state == .on{

            amount += self.checkBox2.tag
            
            selled.updateValue(self.checkBox2.tag, forKey:self.checkBox2.title )

        }

        self.balance = self.balance+Int64(amount)

        
        for (key,value) in self.selledItems{
            
            selled.updateValue(value, forKey: key)
        }
        
        self.selledItems = selled

        
        if self.balance >= 1000000{

            self.showModel(question: "Game completed!", text: "You have won!", buttonTitle: "Reset")
            self.balance = 5000
        }

         self.mainVC.labelBalance.stringValue = "$"+(String(self.balance))
    }
    
    
    func showModel(question:String,text:String,buttonTitle:String){
        
        if buttonTitle == "Ok"{
            
        }else{
            let a = NSAlert()
            a.messageText =  question
            a.informativeText = text
            a.addButton(withTitle:  buttonTitle)
            a.alertStyle = .informational
            
            
            a.beginSheetModal(for: self.view.window!, completionHandler: { (modalResponse) -> Void in
                
                self.view.window?.close()
            })
        }
    }
    
    @IBAction func actionCheckBox(_ sender: NSButton) {
        
    }
}
