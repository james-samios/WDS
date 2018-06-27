import Cocoa

class ShowCountryViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    public var imageName:String! = "IN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = NSImage(named: NSImage.Name(rawValue: self.imageName!))
    }
    
}
