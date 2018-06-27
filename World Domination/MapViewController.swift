import Cocoa

class MapViewController: NSViewController {

    private var imageName:String = "IN"
    
    public var mainVC:Main!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func actionCountryClick(_ sender: NSButton) {
        
        self.imageName = sender.toolTip!
        self.mainVC.state = self.mainVC.states[self.imageName]
        self.mainVC.imageViewMap.image = NSImage(named: NSImage.Name(rawValue: self.imageName))
        
        self.mainVC.news.shuffled()
        self.mainVC.labelNews.stringValue = self.mainVC.news.first!
        
        self.mainVC.labelcurrentLocation.stringValue = "You are currently at: \(String(describing: self.mainVC.states[self.imageName]!)), \(self.imageName)"
        DispatchQueue.main.async {
            self.view.window?.close()
        }
        
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        let vc = segue.destinationController as! ShowCountryViewController
        vc.imageName = self.imageName
    }
}
