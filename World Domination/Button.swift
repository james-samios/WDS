import Cocoa

extension NSButton {
    func setAttributes(foreground: NSColor? = nil, fontSize: CGFloat = -1.0, alignment: NSTextAlignment? = nil) {
        
        var attributes: [NSAttributedStringKey: Any] = [:]
        
        if let foreground = foreground {
            attributes[NSAttributedStringKey.foregroundColor] = foreground
        }
        
        if fontSize != -1 {
            attributes[NSAttributedStringKey.font] = NSFont.systemFont(ofSize: fontSize)
        }
        
        if let alignment = alignment {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = alignment
            attributes[NSAttributedStringKey.paragraphStyle] = paragraph
        }
        
        let attributed = NSAttributedString(string: self.title, attributes: attributes)
        self.attributedTitle = attributed
    }
}

@IBDesignable class Button: NSButton {
    
    @IBInspectable var textColor:NSColor = NSColor.white
    @IBInspectable var fontSize:CGFloat = 24
    
    @IBInspectable var backgroundColor:NSColor = NSColor.black{
        
        didSet{
            
            if let cell = self.cell as? NSButtonCell{
                
                cell.backgroundColor = self.backgroundColor
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.setAttributes(foreground: self.textColor, fontSize: self.fontSize, alignment: NSTextAlignment.center)
    }
    
    
}
