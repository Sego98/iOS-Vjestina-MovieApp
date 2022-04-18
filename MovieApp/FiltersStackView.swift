import Foundation
import UIKit

class FiltersStackView: UIStackView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    init(filterList: [UIButton]){
        super.init(frame: .zero)
        axis = .horizontal
        alignment = .leading
        spacing = 20
        
        //create StackView of filters
        for button in filterList{
            
            if button.currentAttributedTitle?.string == filterList[0].currentAttributedTitle?.string{ //Bold and underline first filter
                let attributedTitle = NSMutableAttributedString(string: button.currentAttributedTitle?.string ?? "")
                let buttonTitle = button.currentAttributedTitle?.string ?? ""
                attributedTitle.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: 20) as Any, range: NSRange(location: 0, length: buttonTitle.count))
                attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: buttonTitle.count))
                button.setAttributedTitle(attributedTitle, for: .normal)
            }
            
            addArrangedSubview(button)
        }
    }
}
