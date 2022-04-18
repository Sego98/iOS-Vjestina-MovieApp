import Foundation
import UIKit
import SnapKit
import MovieAppData

class TableViewCell: UITableViewCell{
    static let identifier = "TableViewCell"
    private var myImage: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var cellView: UIView!
    private var cornerRadius: CGFloat = 40
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCell()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func buildCell(){ //set views in the cell
        cellView = UIView()
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = cornerRadius
        cellView.layer.masksToBounds = true
        contentView.addSubview(cellView)

        myImage = UIImageView()
        myImage.clipsToBounds = true
        myImage.contentMode = .scaleAspectFit
        myImage.layer.masksToBounds = true
        cellView.addSubview(myImage)
        
        titleLabel = UILabel()
        cellView.addSubview(titleLabel)
        
        descriptionLabel = UILabel()
        cellView.addSubview(descriptionLabel)
        
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
    
    public func configure(id: UUID, movies: Array<MovieModel>, bounds: CGRect){
        
        for movie in movies{
            if movie.id == id{
                //set movie image
                let url = URL(string: movie.imageUrl)
                let data = try? Data(contentsOf: url!)
                myImage.image = UIImage(data: data!)
                
                //set movie title
                let mutableString = movie.title + " (" + String(movie.year) +  ")"
                let attributedTitle = NSMutableAttributedString(string: mutableString)
                attributedTitle.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: 25) as Any, range: NSRange(location: 0, length: mutableString.count))
                titleLabel.attributedText = attributedTitle
                titleLabel.numberOfLines = 0
                titleLabel.lineBreakMode = .byWordWrapping
                titleLabel.textAlignment = .natural
                titleLabel.sizeToFit()
                
                //set description of a movie
                let attributedText = NSMutableAttributedString(string: movie.description)
                attributedText.addAttribute(.font, value: UIFont(name: "Arial", size: 16) as Any, range: NSRange(location: 0, length: movie.description.count))
                descriptionLabel.attributedText = attributedText
                descriptionLabel.numberOfLines = 0
                descriptionLabel.lineBreakMode = .byWordWrapping
                descriptionLabel.textAlignment = .natural
                descriptionLabel.sizeToFit()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImage.image = nil
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
    }
    
    //cell constraints
    func addConstraints(){
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myImage.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.equalTo(MovieListViewController.imageWidth)
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalTo(myImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(myImage.snp.trailing).offset(20)
            $0.trailing.bottom.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
