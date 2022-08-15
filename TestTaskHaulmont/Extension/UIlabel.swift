
import UIKit

extension UILabel {

    convenience init(text: String,
                     font: UIFont?,
                     color: UIColor,
                     lines: Int = 1,
                     alignment: NSTextAlignment = .center) {
        self.init()

        self.text = text
        self.textColor = color
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}
