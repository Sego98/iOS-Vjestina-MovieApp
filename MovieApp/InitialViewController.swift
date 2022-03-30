import Foundation
import UIKit
import PureLayout

class InitialViewController: UIViewController{
    //custom colors
    let backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2   , alpha: 1)
    let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    //screen bounds
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        BuildScreen()
    }
   
    private func BuildScreen(){
        //movie image
        let movieImage = UIImageView(image: UIImage(named: "Hobbit"))
        view.addSubview(movieImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -screenHeight/2+60).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        //user score label
        let userScore = CreateLabel(text: "78% User Score", fontName: "Arial", fontSize: 20)
        view.addSubview(userScore)
        userScore.translatesAutoresizingMaskIntoConstraints = false
        userScore.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 200).isActive = true
        userScore.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 20).isActive = true

        //name label
        let name = CreateLabel(text: "The Hobbit", fontName: "ArialRoundedMTBold", fontSize: 35)
        view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: userScore.bottomAnchor, constant: 5).isActive = true
        name.leadingAnchor.constraint(equalTo: userScore.leadingAnchor).isActive = true
        
        //year label
        let year = CreateLabel(text: "(2012)", fontName: "Arial", fontSize: 35)
        view.addSubview(year)
        year.translatesAutoresizingMaskIntoConstraints = false
        year.topAnchor.constraint(equalTo: userScore.bottomAnchor, constant: 5).isActive = true
        year.leadingAnchor.constraint(equalTo: name.trailingAnchor).isActive = true
        
        //date label
        let date = CreateLabel(text: "14/12/2012 (US)", fontName: "Arial", fontSize: 20)
        view.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        date.leadingAnchor.constraint(equalTo: userScore.leadingAnchor).isActive = true
        
        //genre label
        let genre = CreateLabel(text: "Adventure, Fantasy", fontName: "Arial", fontSize: 20)
        view.addSubview(genre)
        genre.translatesAutoresizingMaskIntoConstraints = false
        genre.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 5).isActive = true
        genre.leadingAnchor.constraint(equalTo: userScore.leadingAnchor).isActive = true
        
        //duration label
        let duration = CreateLabel(text: "2h 49m", fontName: "ArialRoundedMTBold", fontSize: 20)
        view.addSubview(duration)
        duration.translatesAutoresizingMaskIntoConstraints = false
        duration.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 5).isActive = true
        duration.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 10).isActive = true
        
        //star button
        //let star = UIButton()
        let imageHeart = UIImageView(image: UIImage(systemName: "heart"))
        imageHeart.contentMode = .scaleToFill
        //star.setBackgroundImage(imageHeart, for: UIControl.State.normal)
        //imageHeart.bounds = CGRect(x: screenWidth/2, y: screenHeight/2 , width: 100, height: 100)
        imageHeart.backgroundColor = .yellow
        view.addSubview(imageHeart)
        imageHeart.translatesAutoresizingMaskIntoConstraints = false
        imageHeart.topAnchor.constraint(equalTo: genre.bottomAnchor).isActive = true
        imageHeart.leadingAnchor.constraint(equalTo: genre.leadingAnchor).isActive = true
        imageHeart.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -5).isActive = true
        
        let overview = CreateLabel(text: "Overview", fontName: "ArialRoundedMTBold", fontSize: 35)
        view.addSubview(overview)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20).isActive = true
        overview.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 20).isActive = true
        
        let multiline = CreateLabel(text: "A reluctant Hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home, and the gold within it from the dragon Smaug.", fontName: "Arial", fontSize: 20)
        view.addSubview(multiline)
        multiline.translatesAutoresizingMaskIntoConstraints = false
        multiline.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 5).isActive = true
        multiline.leadingAnchor.constraint(equalTo: overview.leadingAnchor).isActive = true
        multiline.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -20).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let secondStackView = UIStackView()
        secondStackView.axis = .horizontal
        secondStackView.alignment = .fill
        secondStackView.distribution = .fillProportionally
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondStackView)
        
        //director label
        let director = CreateLabelTwoRows(labelText: "Peter JacksonDirector")
        view.addSubview(director)
        
        //screenplay label
        let screenplay = CreateLabelTwoRows(labelText: "Fran Walsh Screenplay")
        view.addSubview(screenplay)
        
        //music label
        let music = CreateLabelTwoRows(labelText: "Howard Shore Music")
        view.addSubview(music)
        
        //casting label
        let casting = CreateLabelTwoRows(labelText: "Scot Boland Casting")
        view.addSubview(casting)
        
        //artDirection label
        let artDirection = CreateLabelTwoRows(labelText: "Simon Bright Art Direction")
        view.addSubview(artDirection)
        
        //costume label
        let costume = CreateLabelTwoRows(labelText: "Bob Buck Costume")
        view.addSubview(costume)
        
        stackView.addArrangedSubview(director)
        stackView.addArrangedSubview(screenplay)
        stackView.addArrangedSubview(music)
        
        stackView.topAnchor.constraint(equalTo: multiline.bottomAnchor, constant: 15).isActive = true
        stackView.leadingAnchor.constraint(equalTo: multiline.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: multiline.trailingAnchor).isActive = true
        
        secondStackView.addArrangedSubview(casting)
        secondStackView.addArrangedSubview(artDirection)
        secondStackView.addArrangedSubview(costume)

        secondStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15).isActive = true
        secondStackView.leadingAnchor.constraint(equalTo: multiline.leadingAnchor).isActive = true
        secondStackView.trailingAnchor.constraint(equalTo: multiline.trailingAnchor).isActive = true
        
    }
    
    //creating label
    private func CreateLabel(text: String, fontName: String, fontSize: CGFloat) -> UILabel{
        let label = UILabel()
        label.backgroundColor = transparentColor
        label.text = text
        //label.frame = CGRect(x: x, y: y, width: width, height: height)
        label.textColor = .white
        label.font = UIFont(name: fontName, size: fontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
    
    //creating label with two rows
    private func CreateLabelTwoRows(labelText: String) -> UILabel{
        let labelText = labelText
        let attributedText = NSMutableAttributedString(string: labelText)
        //let font = UIFont(name: "ArialRoundedMTBold", size: 20)
        var counter: Int = 0
        var length: Int = 0
        var name: String = ""
        
        //calculate name and its length
        for i in labelText{
            if i != " "{
                length += 1
                name += String(i)
                continue
            }
            else if i == " " && counter == 0{
                length += 1
                counter += 1
                name += String(i)
            }
            else{
                break
            }
        }
        
        attributedText.addAttribute(
            .font,
            value: UIFont(name: "ArialRoundedMTBold", size: 17) as Any,
            range: NSRange(location: 0, length: length)
        )
        attributedText.addAttribute(
            .font,
            value: UIFont(name: "Arial", size: 17) as Any,
            range: NSRange(location: length + 1, length: labelText.count - length - 1))
        
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attributedText
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = transparentColor
        label.textColor = .white
        label.sizeToFit()
        return label
    }
}
