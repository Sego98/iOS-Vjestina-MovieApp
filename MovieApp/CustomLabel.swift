import Foundation
import UIKit

class CustomLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //set label attributes
    init(title: String){
        super.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedTitle.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: 25) as Any, range: NSRange(location: 0, length: title.count))
        attributedText = attributedTitle
        backgroundColor = .clear
        textAlignment = .left
        sizeToFit()
    }
}
