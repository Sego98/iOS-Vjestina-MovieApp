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
    var freeStack: TitleStackView!
    var trendingStack: TitleStackView!
    var topStack: TitleStackView!
    var upcomingStack: TitleStackView!

    var popularCollection: MoviesCollectionView!
    var freeCollection: MoviesCollectionView!
    var trendingCollection: MoviesCollectionView!
    var topCollection: MoviesCollectionView!
    var upcomingCollection: MoviesCollectionView!
    
    static var moviesTable: UITableView!

    static let movies = Movies.all()
    static var searchedMovies = [MovieModel]()
    
    static let imageWidth = 150
    static let imageHeight = 200
    
    var movieListPopular = [UUID]()
    var movieListFree = [UUID]()
    var movieListTrending = [UUID]()
    var movieListTop = [UUID]()
    var movieListUpcoming = [UUID]()
    var foundMovies = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildScreen()
        createTable()
        addMainConstraints()
        addTableConstraints()
    }
}

extension MovieListViewController{
    private func buildScreen(){
        view.backgroundColor = .white
        
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
            let group = movie.group
            for type in group{
                switch type {
                    case .popular:
                        movieListPopular.append(movie.id)
                    case .freeToWatch:
                        movieListFree.append(movie.id)
                    case .trending:
                        movieListTrending.append(movie.id)
                    case .topRated:
                        movieListTop.append(movie.id)
                    case .upcoming:
                        movieListUpcoming.append(movie.id)
                }
            }
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
        freeStack = TitleStackView(titleName: "Free to watch", filterNames: ["Movies", "On TV"])
        MovieListViewController.contentView.addSubview(freeStack)
 
        freeCollection = MoviesCollectionView()
        freeCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        freeCollection.dataSource = self
        freeCollection.delegate = self
        MovieListViewController.contentView.addSubview(freeCollection)
        
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
        
        //upcoming category
        upcomingStack = TitleStackView(titleName: "What is availlable soon?", filterNames: ["This week", "This month"])
        MovieListViewController.contentView.addSubview(upcomingStack)
        
        upcomingCollection = MoviesCollectionView()
        upcomingCollection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        upcomingCollection.dataSource = self
        upcomingCollection.delegate = self
        MovieListViewController.contentView.addSubview(upcomingCollection)
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
                return movieListPopular.count
                
            case freeCollection:
                return movieListFree.count
            
            case trendingCollection:
                return movieListTrending.count
            
            case topCollection:
                return movieListTop.count
            
            case upcomingCollection:
                return movieListUpcoming.count
        
            default:
                fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else{
            fatalError()
        }
        
        switch collectionView{
            case popularCollection:
            cell.configure(id: movieListPopular[indexPath.row], movies: MovieListViewController.movies)
            case freeCollection:
            cell.configure(id: movieListFree[indexPath.row], movies: MovieListViewController.movies)
            case trendingCollection:
            cell.configure(id: movieListTrending[indexPath.row], movies: MovieListViewController.movies)
            case topCollection:
            cell.configure(id: movieListTop[indexPath.row], movies: MovieListViewController.movies)
            case upcomingCollection:
            cell.configure(id: movieListUpcoming[indexPath.row], movies: MovieListViewController.movies)
            default:
                fatalError()
        }
        return cell
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
        
        freeStack.snp.makeConstraints {
            $0.top.equalTo(popularCollection.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
        }
        
        freeCollection.snp.makeConstraints {
            $0.top.equalTo(freeStack.snp.bottom).offset(10)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
        
        trendingStack.snp.makeConstraints {
            $0.top.equalTo(freeCollection.snp.bottom).offset(20)
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
        }
        
        upcomingStack.snp.makeConstraints {
            $0.top.equalTo(topCollection.snp.bottom).offset(20)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
        }
        
        upcomingCollection.snp.makeConstraints {
            $0.top.equalTo(upcomingStack.snp.bottom).offset(10)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(MovieListViewController.imageHeight)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    //constraints for table screen
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
