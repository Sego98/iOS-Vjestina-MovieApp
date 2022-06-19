import Foundation
import UIKit
import SnapKit
import MovieAppData

class SearchBarView: UIStackView {
    private var magnifier: UIImageView!
    private var deny: UIButton!
    private var cancel: UIButton!
    private var stackView: UIStackView!
    private var search: UITextField!
    private var moviesTable: UITableView!
    private var movies = Movies.all()
    
    static var inputText: String!
    
    private let searchBackground = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    
    private var barHeight: Int = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    init(){
        super.init(frame: .zero)
        //magnifier picture
        magnifier = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        magnifier.tintColor = .gray
        magnifier.contentMode = .scaleAspectFit
        
        magnifier.snp.makeConstraints {
            $0.height.width.equalTo(barHeight-10)
        }
        
        //deny button
        deny = UIButton()
        deny.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        deny.clipsToBounds = true
        deny.tintColor = .gray
        deny.addTarget(self, action: #selector(denyTapped), for: .touchUpInside)
        
        deny.snp.makeConstraints {
            $0.height.width.equalTo(barHeight-20)
        }
        
        //search bar
        search = UITextField()
        search.backgroundColor = searchBackground
        search.placeholder = "Search"
        search.textAlignment = .left
        search.layer.cornerRadius = 15
        search.clipsToBounds = true
        search.adjustsFontSizeToFitWidth = true
        search.rightViewMode = .whileEditing
        search.rightView = deny
        search.leftViewMode = .always
        search.leftView = magnifier
        search.delegate = self

        search.snp.makeConstraints {
            $0.height.equalTo(barHeight)
        }
        
        axis = .horizontal
        alignment = .leading
        distribution = .fill
        spacing = 20
        addArrangedSubview(search)
    }
}


extension SearchBarView: UITextFieldDelegate{ //protocol funtions for search bar
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnSearchBar(textField: textField)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        returnSearchBar(textField: textField)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cancel = UIButton()
        cancel.backgroundColor = .clear
        let attributedTitle = NSMutableAttributedString(string: "Cancel")
        attributedTitle.addAttribute(.font, value: UIFont(name: "Arial", size: 20) as Any, range: NSRange(location: 0, length: "Cancel".count))
        cancel.setAttributedTitle(attributedTitle, for: .normal)
        cancel.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        addArrangedSubview(cancel)
        reloadTable()
        tableAvailable()
        
        cancel.snp.makeConstraints {
            $0.height.equalTo(barHeight)
        }
 
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            makeSearch(textField: textField)
        }
        else{
            reloadTable()
        }
        tableAvailable()
    }
}

extension SearchBarView{
    @objc func cancelTapped(){ //button cancel tapped
        search.resignFirstResponder()
        cancel.removeFromSuperview()
        contentAvailable()
        search.text = ""
        reloadTable()
    }
    
    @objc func denyTapped(){ //button x tapped
        search.text = ""
        reloadTable()
        tableAvailable()
    }
    
    private func reloadTable(){ //show table with all movies
        MovieListViewController.searchedMovies.removeAll()
        for movie in MovieListViewController.movies{
            MovieListViewController.searchedMovies.append(movie)
        }
        MovieListViewController.moviesTable.reloadData()
    }
    
    private func makeSearch(textField: UITextField){ //show movies that match searched text
        if (textField.text?.count)! != 0{
            MovieListViewController.searchedMovies.removeAll()
            let textInBar = textField.text ?? ""
            for movie in MovieListViewController.movies{
                let range = movie.title.lowercased().range(of: textInBar, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    MovieListViewController.searchedMovies.append(movie)
                }
            }
        }
        MovieListViewController.moviesTable.reloadData()
    }
    
    private func tableAvailable(){ //show table screen
        MovieListViewController.contentView.isHidden = true
        MovieListViewController.tableView.isHidden = false
    }
    
    private func contentAvailable(){ //show content screen
        MovieListViewController.contentView.isHidden = false
        MovieListViewController.tableView.isHidden = true
    }
    
    private func returnSearchBar(textField: UITextField){
        textField.resignFirstResponder()
        search.text = ""
        cancel.removeFromSuperview()
        contentAvailable()
        MovieListViewController.searchedMovies.removeAll()
        reloadTable()
    }
}

