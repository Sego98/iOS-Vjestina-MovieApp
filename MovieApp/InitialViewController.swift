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
    private var starButton: UIButton!
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addAnimations()
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
                    addConstraints()
                }
            }
        }
    }
    
    private func buildScreen(){
        scrollView = UIScrollView()
        scrollView.backgroundColor = backgroundColor
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.backgroundColor = backgroundColor
        scrollView.addSubview(contentView)
        contentView.isHidden = true
       
        movieImage = UIImageView()
        contentView.addSubview(movieImage)
            
        userScore = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(userScore)

        name = createLabel(text: "", fontName: "ArialRoundedMTBold", fontSize: 40, color: .white)
        name.numberOfLines = 1
        movieImage.addSubview(name)

        year = createLabel(text: "", fontName: "Arial", fontSize: 40, color: .white)
        movieImage.addSubview(year)

        date = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(date)

        genre = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .white)
        movieImage.addSubview(genre)

        duration = createLabel(text: "", fontName: "ArialRoundedMTBold", fontSize: 20, color: .white)
        movieImage.addSubview(duration)

        starButton = UIButton()
        starButton.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.6)
        starButton.layer.cornerRadius = 20
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.tintColor = .white
        starButton.clipsToBounds = true
        starButton.imageView?.contentMode = .scaleToFill
        starButton.imageView?.clipsToBounds = true
        movieImage.addSubview(starButton)
            
        overview = createLabel(text: "Overview", fontName: "ArialRoundedMTBold", fontSize: 35, color: .black)
        contentView.addSubview(overview)
        
        multiline = createLabel(text: "", fontName: "Arial", fontSize: 20, color: .black)
        contentView.addSubview(multiline)
            
        let director = createVerticalStack(name: "Peter Jackson", title: "Director")
        let screenplay = createVerticalStack(name: "Fran Walsh", title: "Screenplay")
        let music = createVerticalStack(name: "Howard Shore", title: "Music")
        self.stackView1 = createHorizontalStack(name1: director, name2: screenplay, name3: music)

        let casting = createVerticalStack(name: "Scot Boland", title: "Casting  ")
        let artDirection = createVerticalStack(name: "Simon Bright", title: "Art Direction")
        let costume = createVerticalStack(name: "Bob Buck", title: "Costume")
        self.stackView2 = createHorizontalStack(name1: casting, name2: artDirection, name3: costume)
    
        stackView1.isHidden = true
        stackView2.isHidden = true
        }
        
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
        
        movieImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
        }
        
        userScore.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(20)
        }

        year.snp.makeConstraints {
            $0.top.equalTo(name.snp.top)
            $0.leading.equalTo(name.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        duration.snp.makeConstraints {
            $0.top.equalTo(date.snp.bottom).offset(5)
            $0.leading.equalTo(genre.snp.trailing).offset(10)
        }
        
        starButton.snp.makeConstraints {
            $0.top.equalTo(genre.snp.bottom).offset(3)
            $0.leading.equalTo(genre.snp.leading)
            $0.width.height.equalTo(35)
        }
        
        overview.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.bottom).offset(20)
            $0.leading.equalTo(movieImage.snp.leading).offset(20)
        }
        
        multiline.snp.makeConstraints {
            $0.top.equalTo(overview.snp.bottom).offset(5)
            $0.leading.equalTo(overview.snp.leading)
            $0.trailing.equalTo(movieImage.snp.trailing).inset(20)
        }
        
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
    
    func addAnimations() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.name.snp.makeConstraints {
                $0.top.equalTo(self.userScore.snp.bottom).offset(5)
                $0.leading.equalTo(self.movieImage.snp.leading).offset(20)
            }
            self.view.layoutIfNeeded()
            }, completion: nil)

        UIView.animate(withDuration: 1, delay: 0.5, options: .curveLinear, animations: {
            self.date.snp.remakeConstraints {
                $0.top.equalTo(self.name.snp.bottom).offset(10)
                $0.leading.equalToSuperview().offset(20)
            }
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.75, options: .curveEaseInOut, animations: {
            self.genre.snp.makeConstraints {
                $0.top.equalTo(self.date.snp.bottom).offset(5)
                $0.leading.equalTo(self.userScore.snp.leading)
            }
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}
