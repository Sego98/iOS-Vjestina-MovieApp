import Foundation
import UIKit
import SnapKit
import MovieAppData

class CustomCollectionViewCell: UICollectionViewCell{
    static let identifier = "CustomCollectionVewCell"
    static var imageID: Int = 0
    private let heartColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 0.4)
    public var myImage: UIButton!
    public var myLabel: UILabel!
    private var myButton: UIButton!
    
    private let buttonDimension: Int = 32
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func buildCell(){ //set views in the cell
        contentView.backgroundColor = .white
        myImage = UIButton()
        myImage.clipsToBounds = true
        myImage.contentMode = .scaleAspectFit
        myImage.layer.cornerRadius = 10
        contentView.addSubview(myImage)
        
        myButton = UIButton()
        myButton.frame = CGRect(x: 0, y: 0, width: buttonDimension, height: buttonDimension)
        myButton.setImage(UIImage(systemName: "heart"), for: .normal)
        myButton.contentMode = .scaleToFill
        myButton.clipsToBounds = true
        myButton.layer.cornerRadius = CGFloat(buttonDimension/2)
        myButton.backgroundColor = heartColor
        myButton.tintColor = .white
        myButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        myImage.addSubview(myButton)
    }
    
    public func configure(movieURL: String, id: Int){
                //set cell image
        CustomCollectionViewCell.imageID = id
        let url = URL(string: movieURL)
        let data = try? Data(contentsOf: url!)
        myImage.setImage(UIImage(data: data!), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImage.setImage(nil, for: .normal)
    }
    
    @objc func heartTapped(){
        if myButton.currentImage == UIImage(systemName: "heart") {
            myButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            myButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    
    //cell constraints
    func addConstraints() {
        myImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
        
        myButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalToSuperview().offset(9)
            $0.height.width.equalTo(buttonDimension)
        }
    }
}
