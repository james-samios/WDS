import Cocoa

class Main: NSViewController {

    @IBOutlet weak var imageViewMap: NSButton!
    @IBOutlet weak var labelcurrentLocation: NSTextField!
    @IBOutlet weak var labelNews: NSTextField!
    @IBOutlet weak var labelBalance: NSTextField!
    @IBOutlet weak var labelOpenOrderCount: NSTextField!
    
    public var news = [
        
        "A hurricane has hit Beijing, China. All exports are temporarily disabled until further notice (lasts for 1 hour)",
        "An earthquake has hit Brussels, Belgium. All exports and imports are temporarily disabled until further notice (lasts for 40 mins)",
        
        "A riot has struck Sydney, Australia. All exports are temporarily disabled until further notice (lasts for 40 mins)",
        "A shortage of Assamese Silk has struck Delhi, India. (lasts for 1 hour)",
        "A factory that manufactures Twinkies and Pop Tarts in Los Angeles, USA has been raided. All exports are temporarily disabled until further notice (lasts for 20 mins)",
        "A German Gummy Bear factory has had a terrible accident. Gummy Bears are temporarily disabled until further notice (lasts for 1.5 hours)"
    ]
    
    let states = ["IN":"DELHI","AU":"SYDNEY","CN":"BEIJING","DE":"BERLIN","US":"LOS ANGELES","BE":"BRUSSELS"]
    
    let items = [
        "DELHI": ["Indian Pickles":50, "Assamese Silk":140],
        "BEIJING": ["Silk":290, "Fresh Water Pearls":510],
        "BERLIN": ["German Gummy Bears":60,"Watermelon-Mind Shower Gel":95],
        "SYDNEY": ["Eucalyptus Drops":10, "Vegemite":20],
        "LOS ANGELES": ["Twinkies":40, "Pop Tarts":25],
        "BRUSSELS": ["Belgium Chocolate":75, "Belgium Waffle Maker":160]]
    
    var state:String! = "SYDNEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        
        if let country = Locale.current.regionCode{
            
            if let image = NSImage(named: NSImage.Name(rawValue: country)){
                
                self.imageViewMap.image = image
                
            }
            self.state = self.states[country]!
            self.labelcurrentLocation.stringValue = "You are currently at: \(self.state!), \(country)"
            
            Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.sayHello), userInfo: nil, repeats: true)

        }
        
        self.labelBalance.stringValue = "$"+String(self.balance)
        

        self.labelOpenOrderCount.stringValue = String(self.purchasedItems.count)

    }
    
    
    @objc private func sayHello()
    {
        self.news.shuffled()
        self.labelNews.stringValue = self.news.first!
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        self.news.shuffled()
        self.labelNews.stringValue = self.news.first!
    }
    
    @IBAction func actionPurchaseOrSell(_ sender: Button) {
        
        self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "PurchaseItemsVC"), sender: self)
    }
    
    @IBAction func acionMap(_ sender: NSButton) {
        
        self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "MapViewController"), sender: self)
    }
    
    @IBAction func actionViewOpenOrders(_ sender: Button) {
        
        self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "OpenOrdersVC"), sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if segue.identifier!.rawValue == "MapViewController"{
            
            let vc = segue.destinationController as! MapViewController
            vc.mainVC = self
        }else if segue.identifier!.rawValue == "PurchaseItemsVC"{
            
            let vc = segue.destinationController as! PurchaseItemsVC
            vc.items = self.items[self.state]!
            vc.mainVC = self
        }else if segue.identifier!.rawValue == "OpenOrdersVC"{
            
            let vc = segue.destinationController as! OpenOrdersVC
            vc.mainVC = self
        }
    }
}
