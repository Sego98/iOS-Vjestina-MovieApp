import Foundation
import UIKit

class TitleStackView: UIStackView{
    private var nameTitle: CustomLabel!
    private var filter: CustomButton!
    private var filterStack: FiltersStackView!
    var filterList = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    init(titleName: String, filterNames: [String]){
        super.init(frame: .zero)
        axis = .vertical
        alignment = .leading
        distribution = .fillProportionally
        spacing = 10
        backgroundColor = .clear
        
        nameTitle = CustomLabel(title: titleName)
        addArrangedSubview(nameTitle)
        
        //create list of filter buttons and add targets
        for name in filterNames{
            filter = CustomButton(title: name)
            filterList.append(filter)
        }
        
        for i in filterList{
            i.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        }

        filterStack = FiltersStackView(filterList: filterList)
        addArrangedSubview(filterStack)
    }
}

extension TitleStackView{
    @objc func buttonTapped(sender: UIButton){
        let title = sender.currentAttributedTitle?.string ?? ""
        for k in filterList{
            let currentTitle = k.currentAttributedTitle?.string ?? ""
            let attributedTitle = NSMutableAttributedString(string: currentTitle)
            //change to bold and underlined text
            if title == currentTitle{
                attributedTitle.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: 20) as Any, range: NSRange(location: 0, length: currentTitle.count))
                sender.setAttributedTitle(attributedTitle, for: .normal)
                attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: currentTitle.count))
            }
            //change to normal text
            else{
                attributedTitle.addAttribute(.font, value: UIFont(name: "Arial", size: 20) as Any, range: NSRange(location: 0, length: currentTitle.count))
                k.setAttributedTitle(attributedTitle, for: .normal)
            }
        }
    }
}
