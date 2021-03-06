import Foundation
import UIKit
import SnapKit

class InitialViewController: UIViewController{
    //custom colors
    private let backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    private let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var movieImage: UIImageView!
    private var userScore: UILabel!
    private var name: UILabel!
    private var year: UILabel!
    private var date: UILabel!
    private var genre: UILabel!
    private var duration: UILabel!
    private var imageStar: UIImageView!
    private var overview: UILabel!
    private var multiline: UILabel!
    private var stackView1: UIStackView!
    private var stackView2: UIStackView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        BuildScreen()
        AddConstraints()
    }
    
    private func BuildScreen(){
        scrollView = UIScrollView()
        contentView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
   
        //movie image
        movieImage = UIImageView(image: UIImage(named: "Hobbit"))
        contentView.addSubview(movieImage)
        
        //user score label
        userScore = CreateLabel(text: "78% User Score", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(userScore)

        //name label
        name = CreateLabel(text: "The Hobbit", fontName: "ArialRoundedMTBold", fontSize: 40, color: .white)
        movieImage.addSubview(name)

        //year label
        year = CreateLabel(text: "(2012)", fontName: "Arial", fontSize: 40, color: .white)
        movieImage.addSubview(year)

        //date label
        date = CreateLabel(text: "14/12/2012 (US)", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(date)

        //genre label
        genre = CreateLabel(text: "Adventure, Fantasy", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(genre)

        //duration label
        duration = CreateLabel(text: "2h 49m", fontName: "ArialRoundedMTBold", fontSize: 20, color: .white)
        movieImage.addSubview(duration)

        //star button
        //let star = UIButton()
        imageStar = UIImageView(image: UIImage(systemName: "star"))
        imageStar.layer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.6).cgColor
        imageStar.layer.cornerRadius = 20
        imageStar.clipsToBounds = true
        imageStar.tintColor = .white
        movieImage.addSubview(imageStar)
        
        //overview label
        overview = CreateLabel(text: "Overview", fontName: "ArialRoundedMTBold", fontSize: 35, color: .black)
        contentView.addSubview(overview)
        
        //multiline text label
        multiline = CreateLabel(text: "A reluctant Hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home, and the gold within it from the dragon Smaug.", fontName: "Arial", fontSize: 20, color: .black)
        contentView.addSubview(multiline)
        
        //first horizontal stack view
        let director = CreateVerticalStack(name: "Peter Jackson", title: "Director")
        let screenplay = CreateVerticalStack(name: "Fran Walsh", title: "Screenplay")
        let music = CreateVerticalStack(name: "Howard Shore", title: "Music")
        stackView1 = CreateHorizontalStack(name1: director, name2: screenplay, name3: music)

        //second horizontal stack view
        let casting = CreateVerticalStack(name: "Scot Boland", title: "Casting  ")
        let artDirection = CreateVerticalStack(name: "Simon Bright", title: "Art Direction")
        let costume = CreateVerticalStack(name: "Bob Buck", title: "Costume")
        stackView2 = CreateHorizontalStack(name1: casting, name2: artDirection, name3: costume)
    }
    
    private func AddConstraints(){
        /*Constraints for scrollView and contentView are same as in the presentation
        but for some reason scrolling doesn't work. :( */
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
               }

        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 380).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        userScore.translatesAutoresizingMaskIntoConstraints = false
        userScore.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 200).isActive = true
        userScore.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 20).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: userScore.bottomAnchor, constant: 5).isActive = true
        name.leadingAnchor.constraint(equalTo: userScore.leadingAnchor).isActive = true
        
        year.translatesAutoresizingMaskIntoConstraints = false
        year.topAnchor.constraint(equalTo: userScore.bottomAnchor, constant: 5).isActive = true
        year.leadingAnchor.constraint(equalTo: name.trailingAnchor).isActive = true
        
        date.translatesAutoresizingMaskIntoConstraints = false
        date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        date.leadingAnchor.constraint(equalTo: userScore.leadingAnchor).isActive = true
        
        genre.translatesAutoresizingMaskIntoConstraints = false
        genre.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 5).isActive = true
        genre.leadingAnchor.constraint(equalTo: userScore.leadingAnchor).isActive = true
        
        duration.translatesAutoresizingMaskIntoConstraints = false
        duration.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 5).isActive = true
        duration.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 10).isActive = true
        
        imageStar.translatesAutoresizingMaskIntoConstraints = false
        imageStar.topAnchor.constraint(equalTo: genre.bottomAnchor).isActive = true
        imageStar.leadingAnchor.constraint(equalTo: genre.leadingAnchor).isActive = true
        imageStar.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageStar.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20).isActive = true
        overview.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 20).isActive = true
        
        multiline.translatesAutoresizingMaskIntoConstraints = false
        multiline.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 5).isActive = true
        multiline.leadingAnchor.constraint(equalTo: overview.leadingAnchor).isActive = true
        multiline.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -20).isActive = true
        
        stackView1.topAnchor.constraint(equalTo: multiline.bottomAnchor, constant: 20).isActive = true
        stackView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20).isActive = true
        stackView2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    //creating label
    private func CreateLabel(text: String, fontName: String, fontSize: CGFloat, color: UIColor) -> UILabel{
        let label = UILabel()
        label.backgroundColor = transparentColor
        label.text = text
        label.textColor = color
        label.font = UIFont(name: fontName, size: fontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
    
    //creating vertical stack view with two labels
    private func CreateVerticalStack(name: String, title: String) -> UIStackView{
        let attributedName = NSMutableAttributedString(string: name)
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedName.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: 15) as Any, range: NSRange(location: 0, length: name.count))
        attributedTitle.addAttribute(.font, value: UIFont(name: "Arial", size: 15) as Any, range: NSRange(location: 0, length: title.count))
        
        let nameLabel = UILabel()
        nameLabel.attributedText = attributedName
        nameLabel.backgroundColor = transparentColor
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.sizeToFit()
        contentView.addSubview(nameLabel)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedTitle
        titleLabel.backgroundColor = transparentColor
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(titleLabel)
        
        return stackView
    }
    
    //creating horizontal stack with three elements
    private func CreateHorizontalStack(name1: UIStackView, name2: UIStackView, name3: UIStackView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(name1)
        stackView.addArrangedSubview(name2)
        stackView.addArrangedSubview(name3)
        
        return stackView
    }
}
