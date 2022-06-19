import Foundation
import UIKit
import SnapKit
import MovieAppData

class CustomCollectionViewCell: UICollectionViewCell{
    static let identifier = "CustomCollectionVewCell"
    static var imageID: Int = 0
    private let heartColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 0.4)
    public var myImage: UIImageView!
    public var myLabel: UILabel!
    private var myButton: UIButton!
    private var movieId: Int!
    
    private let buttonDimension: Int = 32
    
    var title: String!
    
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
        myImage = UIImageView()
        myImage.clipsToBounds = true
        //myImage.contentMode = .scaleToFill
        myImage.contentMode = .scaleAspectFill
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
        contentView.addSubview(myButton)
    }
    
    public func configure(movieURL: String, movieID: Int){
        let url = URL(string: movieURL)
        let data = try? Data(contentsOf: url!)
        myImage.image = UIImage(data: data!)
        movieId = movieID
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImage.image = nil
        movieId = nil
        
    }
    
    @objc func heartTapped(sender: UIButton){
        if myButton.currentImage == UIImage(systemName: "heart") {
            UIView.transition(with: sender, duration: 1, options: .transitionCrossDissolve, animations: {
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        }, completion: nil)

        }
        else{
            UIView.transition(with: sender, duration: 1, options: .transitionCrossDissolve, animations: {
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                        }, completion: nil)
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
