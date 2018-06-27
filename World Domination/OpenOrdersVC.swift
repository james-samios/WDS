import Cocoa

class OpenOrdersVC: NSViewController {
    
    @IBOutlet weak var tableView:NSTableView!
    
    var tableViewData = [[String:Int]]()

    public var mainVC:Main!
    
    public var soldedItems = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.reloadTableView()
    }
    
    func reloadTableView(){
        
        self.tableViewData.removeAll()
        self.soldedItems.removeAll()
        for (key,value) in self.purchasedItems{
            
            let dict = [key:value]
            self.tableViewData.append(dict)
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func actionSold(_ sender: NSButton) {
        
        var newObject = [String:Int]()
        
        
        for (key,value) in self.purchasedItems{
            
            if self.soldedItems[key] == nil{
                
                newObject.updateValue(value, forKey: key)
            }
        
        }
        
        self.purchasedItems = newObject
        
        var amount:Int64 = 0
        
        for (_,value) in self.soldedItems{
            
            amount += Int64(value)
        }
        
        if self.balance >= amount{
            
            self.balance = self.balance-amount
             self.mainVC.labelBalance.stringValue = "$"+(String(self.balance))
        }
        
        self.reloadTableView()
    }
    
    @objc public func actionCheck(_ sender:NSButton){
        
        let item = self.tableViewData[sender.tag].first!
        
        let boolValue = self.soldedItems.contains { (dict) -> Bool in
            
            return dict == item
        }
        
        if sender.state == .on{
           
            if boolValue == false{
                
                self.soldedItems.updateValue(item.value, forKey: item.key)
            }
        }else{
            
            var solded = [String:Int]()
            solded.updateValue(item.value, forKey: item.key)
            
            for (key,value) in self.soldedItems{
                
                if key != item.key && value != item.value{
                    
                    solded.updateValue(value, forKey: key)
                }
            }
            
            self.soldedItems = solded
        }
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
}


extension OpenOrdersVC:NSTableViewDataSource, NSTableViewDelegate{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        let result:KSTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self) as! KSTableCellView

        let item = self.tableViewData[row]
        result.checkBox.tag = row
        result.checkBox.title = item.first!.key
        result.checkBox.target = self
        result.checkBox.action  = #selector(self.actionCheck(_:))
        return result;
        
    }
    
}
