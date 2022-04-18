import Foundation
import UIKit

class CustomButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //set button attributes
    init(title: String){
        super.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedTitle.addAttribute(.font, value: UIFont(name: "Arial", size: 20) as Any, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedTitle, for: .normal)
        backgroundColor = .clear
        sizeToFit()
    }
}
