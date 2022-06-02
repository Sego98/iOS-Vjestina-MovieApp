import Foundation
import UIKit
import SnapKit
import MovieAppData

class MovieListViewController: UIViewController{
    var scrollView: UIScrollView!
    static var contentView: UIView!
    static var tableView: UIView!
    
    var searchBar: SearchBarView!
    
    var popularStack: TitleStackView!
    var recommendStack: TitleStackView!
    var trendingStack: TitleStackView!
    var topStack: TitleStackView!
    
    var popularCollection: MoviesCollectionView!
    var recommendCollection: MoviesCollectionView!
    var trendingCollection: MoviesCollectionView!
    var topCollection: MoviesCollectionView!
    
    static var moviesTable: UITableView!

    static let movies = Movies.all()
    static var searchedMovies = [MovieModel]()
    
    static let imageWidth = 150
    static let imageHeight = 200
    
    var foundMovies = [UUID]()
    
    var popularURL = [String]()
    var recommendURL = [String]()
    var trendingURL = [String]()
    var topURL = [String]()
    var allURL = [String]()
    
    var popularID = [Int]()
    var recommendID = [Int]()
    var trendingID = [Int]()
    var topID = [Int]()
    var allID = [Int]()
    static var currrentID: Int = 0
    var imageTitle: String!
    
    let networkService: NetworkService! = nil
    var image: UIImage!
    
    struct Movie: Codable{
        let backdrop_path: String?
        let id: Int?
        let original_title: String?
        let overview: String?
    }
    
    var vc: UIViewController!
    
    
    var apiDictionary = [String : NetworkService.Request]()
    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "api_key=d52b5d6006ac52a93e0c09485450af91"
    let baseImageURL = "https://image.tmdb.org/t/p/original"
    
    let favorites = FavoritesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //favorites.DeleteAllData()
        buildScreen()
        createTable()
        networkData()
        addMainConstraints()
        addTableConstraints()
    }
}

extension MovieListViewController{
    private func buildScreen(){
        
        view.backgroundColor = .white
        navigationItem.title = "Movies"
        //set views
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        MovieListViewController.contentView = UIView()
        scrollView.addSubview(MovieListViewController.contentView)
        
        MovieListViewController.tableView = UIView()
        scrollView.addSubview(MovieListViewController.tableView)
        MovieListViewController.tableView.backgroundColor = .white
        MovieListViewController.tableView.isHidden = true
        
        searchBar = SearchBarView()
        scrollView.addSubview(searchBar)
        
        //filter movies by groups
        
        for movie in MovieListViewController.movies{
            MovieListViewController.searchedMovies.append(movie)
        }
        
        //popular category
        popularStack = TitleStackView(titleName: "What's popular", filterNames: ["Streaming", "On TV", "For rent", "In theaters"])
        MovieListViewController.contentView.addSubview(popularStack)
    
        popularCollection = MoviesCollectionView()
        popularCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        popularCollection.dataSource = self
        popularCollection.delegate = self
        MovieListViewController.contentView.addSubview(popularCollection)
        
        //free to watch category
        recommendStack = TitleStackView(titleName: "Recommendations", filterNames: ["Movies", "On TV"])
        MovieListViewController.contentView.addSubview(recommendStack)
 
        recommendCollection = MoviesCollectionView()
        recommendCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        recommendCollection.dataSource = self
        recommendCollection.delegate = self
        MovieListViewController.contentView.addSubview(recommendCollection)
        
        //trrending category
        trendingStack = TitleStackView(titleName: "What's in treninding today", filterNames: ["Movies", "Series", "Reality shows"])
        MovieListViewController.contentView.addSubview(trendingStack)
        
        trendingCollection = MoviesCollectionView()
        trendingCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        trendingCollection.dataSource = self
        trendingCollection.delegate = self
        MovieListViewController.contentView.addSubview(trendingCollection)
        
        //top rated category
        topStack = TitleStackView(titleName: "Top lists", filterNames: ["Top 10", "Top 100"])
        MovieListViewController.contentView.addSubview(topStack)
        
        topCollection = MoviesCollectionView()
        topCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        topCollection.dataSource = self
        topCollection.delegate = self
        MovieListViewController.contentView.addSubview(topCollection)
    }
}

//functions to set table view
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func createTable(){
        MovieListViewController.moviesTable = UITableView()
        MovieListViewController.moviesTable.backgroundColor = .white
        MovieListViewController.moviesTable.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        MovieListViewController.moviesTable.dataSource = self
        MovieListViewController.moviesTable.delegate = self
        MovieListViewController.tableView.addSubview(MovieListViewController.moviesTable)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        
        else{
            fatalError()
        }
        cell.configure(id: MovieListViewController.searchedMovies[indexPath.section].id, movies: MovieListViewController.movies, bounds: cell.bounds)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(MovieListViewController.imageHeight)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieListViewController.searchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

//functions to set collection views
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
            case popularCollection:
            return popularURL.count
                
            case recommendCollection:
            return recommendURL.count
            
            case trendingCollection:
                return trendingURL.count
            
            case topCollection:
                return topURL.count
        
            default:
                fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else{
            fatalError()
        }
        
     //   cell.myImage.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        
        switch collectionView{
            case popularCollection:
                for i in (0...popularURL.count){
                    if i == indexPath.row{
                        cell.configure(movieURL: popularURL[i], movieID: popularID[i])
                    }
                }
            
            case recommendCollection:
                for i in (0...recommendURL.count){
                    if i == indexPath.row{
                        cell.configure(movieURL: recommendURL[i], movieID: recommendID[i])
                    }
                }
            
            case trendingCollection:
                for i in (0...trendingURL.count){
                    if i == indexPath.row{
                        cell.configure(movieURL: trendingURL[i], movieID: trendingID[i])
                    }
                }
            
            case topCollection:
                for i in (0...topURL.count){
                    if i == indexPath.row{
                        cell.configure(movieURL: topURL[i], movieID: topID[i])
                    }
                }
            
            default:
                fatalError()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
            case popularCollection:
                vc = MovieDetailsViewController(movieID: popularID[indexPath.row])
            case recommendCollection:
                vc = MovieDetailsViewController(movieID: recommendID[indexPath.row])
            case trendingCollection:
                vc = MovieDetailsViewController(movieID: trendingID[indexPath.row])
            
            case topCollection:
                vc = MovieDetailsViewController(movieID: topID[indexPath.row])
            default:
                fatalError()
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension MovieListViewController{
    func networkData(){
        //popular
        DispatchQueue.global(qos: .utility).async {
            let urlString = "\(self.baseURL)/movie/popular?language=en-US&page=1&\(self.apiKey)"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let networkService = NetworkService()
            networkService.executeUrlRequest(request){ [self] stringValue, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let value = stringValue else {
                    return
                }
                DispatchQueue.main.async {
                    for movie in value.results{
                        let imageURL = baseImageURL + (movie.backdrop_path)!
                        popularURL.append(imageURL)
                        popularID.append(movie.id!)
                        if allID.contains(movie.id!) == false{
                            allURL.append(imageURL)
                            allID.append(movie.id!)
                        }
                    }
                    popularCollection.reloadData()
                }
            }
        }
        //top
        DispatchQueue.global(qos: .utility).async {
            let urlString = "\(self.baseURL)/movie/top_rated?language=en-US&page=1&\(self.apiKey)"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let networkService = NetworkService()
            networkService.executeUrlRequest(request){ [self] stringValue, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let value = stringValue else {
                    return
                }
                DispatchQueue.main.async {
                    for movie in value.results{
                        let imageURL = baseImageURL + (movie.backdrop_path)!
                        topURL.append(imageURL)
                        topID.append(movie.id!)
                        if allID.contains(movie.id!) == false{
                            allURL.append(imageURL)
                            allID.append(movie.id!)
                        }
                    }
                    topCollection.reloadData()
                }
            }
        }
        //trending
        DispatchQueue.global(qos: .utility).async {
            let urlString = "\(self.baseURL)/trending/movie/week?\(self.apiKey)&page=1"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let networkService = NetworkService()
            networkService.executeUrlRequest(request){ [self] stringValue, error in
                
                if let error = error {
                    print(error)
                    return
                }
                guard let value = stringValue else {
                    return
                }
                DispatchQueue.main.async {
                    for movie in value.results{
                        let imageURL = baseImageURL + (movie.backdrop_path)!
                        trendingURL.append(imageURL)
                        trendingID.append(movie.id!)
                        if allID.contains(movie.id!) == false{
                            allURL.append(imageURL)
                            allID.append(movie.id!)
                        }
                    }
                    trendingCollection.reloadData()
                }
            }
        }
        //recommendations
        DispatchQueue.global(qos: .utility).async {
            let urlString = "\(self.baseURL)/movie/103/recommendations?\(self.apiKey)&language=en-US&page=1"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let networkService = NetworkService()
            networkService.executeUrlRequest(request){ [self] stringValue, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let value = stringValue else {
                    return
                }
                DispatchQueue.main.async {
                    for movie in value.results{
                        let imageURL = baseImageURL + (movie.backdrop_path)!
                        recommendURL.append(imageURL)
                        recommendID.append(movie.id!)
                        if allID.contains(movie.id!) == false{
                            allURL.append(imageURL)
                            allID.append(movie.id!)
                        }
                    }
                    recommendCollection.reloadData()
                }
            }
        }
    }
}

extension MovieListViewController{
    //main screen constraints
    private func addMainConstraints(){
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        MovieListViewController.contentView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(view)
        }

        popularStack.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
        }
        
        popularCollection.snp.makeConstraints {
            $0.top.equalTo(popularStack.snp.bottom).offset(10)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
        
        recommendStack.snp.makeConstraints {
            $0.top.equalTo(popularCollection.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
        }
        
        recommendCollection.snp.makeConstraints {
            $0.top.equalTo(recommendStack.snp.bottom).offset(10)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
        
        trendingStack.snp.makeConstraints {
            $0.top.equalTo(recommendCollection.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
        }
        
        trendingCollection.snp.makeConstraints {
            $0.top.equalTo(trendingStack.snp.bottom).offset(10)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
        
        topStack.snp.makeConstraints {
            $0.top.equalTo(trendingCollection.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
        }
        
        topCollection.snp.makeConstraints {
            $0.top.equalTo(topStack.snp.bottom).offset(10)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(MovieListViewController.imageHeight)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func addTableConstraints(){
            MovieListViewController.tableView.snp.makeConstraints {
                $0.top.equalTo(searchBar.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
                $0.width.equalTo(view)
            }
            
            MovieListViewController.moviesTable.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().inset(20)
            }
        }
}
