import Foundation
import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController{
    //custom colors
    private let backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    private let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    let apiKey = "api_key=d52b5d6006ac52a93e0c09485450af91"
    
    //used variables
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
    
    var movieID: Int
    var movie: Movie!
    
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        networkData()
        buildScreen()
        addConstraints()
    }
    
    private func networkData(){
        DispatchQueue.global(qos: .utility).async {
            let urlString = "https://api.themoviedb.org/3/movie/\(self.movieID)?language=en-US&page=1&\(self.apiKey)"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let networkService = MovieNetworkService()
            networkService.executeUrlRequest(request){ [self] stringValue, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let valueData = stringValue else {
                    return
                }
                movie = valueData
                DispatchQueue.main.async {
                    let url = URL(string: "https://image.tmdb.org/t/p/original\(movie.backdrop_path ?? "")")
                    let data = try? Data(contentsOf: url!)
                    movieImage.image =  UIImage(data: data!)
                    movieImage.contentMode = .scaleToFill
                    
                    var score = movie.vote_average ?? 0
                    score *= 10
                    let scoreString = String(Int(score))
                    userScore.text = "\(scoreString)% User Score"
                    
                    name.text = movie.title
                    
                    let dateNew = movie.release_date
                    let stringArray = Array(dateNew!)
                    var yearNew: String = ""
                    for i in 0...3{
                        yearNew += String(stringArray[i])
                    }
                    year.text = yearNew
                    
                    let production: String
                    if movie.production_countries.count != 0{
                        production = (movie.production_countries[0]?.iso_3166_1)!
                    }
                    else{
                        production = ""
                    }
                    
                    date.text = dateNew! + " " + production

                    duration.text = String(movie.runtime!) + "m"
                    
                    let genres = movie.genres
                    var genresString = ""
                    for genre in genres{
                        let genreName = genre?.name
                        if genre == genres[0] {
                            genresString += (String(genreName!))
                        }
                        else{
                            genresString += (", " + String(genreName!))
                        }
                    }
                    genre.text = genresString
                    
                    multiline.text = movie.overview
                    contentView.isHidden = false
                }
            }
        }
    }
    
private func buildScreen(){        //scroll view
            scrollView = UIScrollView()
        scrollView.backgroundColor = backgroundColor
        view.addSubview(scrollView)
        
        //content view
        contentView = UIView()
        contentView.backgroundColor = backgroundColor
        scrollView.addSubview(contentView)
    contentView.isHidden = true
       
        //movie image
        movieImage = UIImageView()
        contentView.addSubview(movieImage)
            
        //user score label
        userScore = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .white)
   // userScore.isHidden = true
        movieImage.addSubview(userScore)

        //name label
        name = createLabel(text: "", fontName: "ArialRoundedMTBold", fontSize: 40, color: .white)
        movieImage.addSubview(name)

            //year label
        year = createLabel(text: "", fontName: "Arial", fontSize: 40, color: .white)
        movieImage.addSubview(year)

            //date label
        date = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(date)

            //genre label
        genre = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(genre)

        //duration label
        duration = createLabel(text: "", fontName: "ArialRoundedMTBold", fontSize: 20, color: .white)
        movieImage.addSubview(duration)

        //star button
        imageStar = UIImageView(image: UIImage(systemName: "star"))
        imageStar.layer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.6).cgColor
        imageStar.layer.cornerRadius = 20
        imageStar.clipsToBounds = true
        imageStar.tintColor = .white
        movieImage.addSubview(imageStar)
            
        //overview label
        overview = createLabel(text: "Overview", fontName: "ArialRoundedMTBold", fontSize: 35, color: .black)
        contentView.addSubview(overview)
        
        //multiline text label
        multiline = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .black)
        contentView.addSubview(multiline)
            
        //first horizontal stack view
        let director = createVerticalStack(name: "Peter Jackson", title: "Director")
        let screenplay = createVerticalStack(name: "Fran Walsh", title: "Screenplay")
        let music = createVerticalStack(name: "Howard Shore", title: "Music")
        self.stackView1 = createHorizontalStack(name1: director, name2: screenplay, name3: music)

        //second horizontal stack view
        let casting = createVerticalStack(name: "Scot Boland", title: "Casting  ")
        let artDirection = createVerticalStack(name: "Simon Bright", title: "Art Direction")
        let costume = createVerticalStack(name: "Bob Buck", title: "Costume")
        self.stackView2 = createHorizontalStack(name1: casting, name2: artDirection, name3: costume)
    
    stackView1.isHidden = true
    stackView2.isHidden = true
        }
        
        //creating label
        func createLabel(text: String, fontName: String, fontSize: CGFloat, color: UIColor) -> UILabel{
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
        func createVerticalStack(name: String, title: String) -> UIStackView{
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
            contentView.addSubview(stackView)
            stackView.addArrangedSubview(nameLabel)
            stackView.addArrangedSubview(titleLabel)
            
            return stackView
        }
        
        //creating horizontal stack with three elements
        func createHorizontalStack(name1: UIStackView, name2: UIStackView, name3: UIStackView) -> UIStackView {
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
    
    func addConstraints(){
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 380).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
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
        
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.topAnchor.constraint(equalTo: multiline.bottomAnchor, constant: 20).isActive = true
        stackView1.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView1.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20).isActive = true
        stackView2.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView2.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}
