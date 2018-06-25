import Cocoa

class Main: NSViewController {
    
    @IBOutlet weak var imageViewMap: NSButton!
    @IBOutlet weak var labelcurrentLocation: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        
        if let country = Locale.current.regionCode{
            
            if let image = NSImage(named: NSImage.Name(rawValue: country)){
                
                self.imageViewMap.image = image
            }
            
            self.labelcurrentLocation.stringValue  = "You are currently at: \(country)"
        }
        
    }
    @IBAction func acionMap(_ sender: NSButton) {
        
        self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "MapViewController"), sender: self)
    }
    
}
