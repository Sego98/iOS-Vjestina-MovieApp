import Foundation
import UIKit
import CoreData
import SnapKit

class FavoritesViewController: UIViewController{
    private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        navigationItem.title = "Favorites"
        createTable()
        addConstraints()
        

    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{

    func createTable(){
        table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.bounds = view.bounds
        view.addSubview(table)
    }
    
    func relaodTable(){
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviesDatabaseDataSource.movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        //let movies = fetchMovies()
        let movie = MoviesDatabaseDataSource.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        cell.textLabel?.text = movie.value(forKeyPath: "title") as? String
        cell.backgroundColor = .yellow
        return cell
    }
}

extension FavoritesViewController{
    func addConstraints(){
        table.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
