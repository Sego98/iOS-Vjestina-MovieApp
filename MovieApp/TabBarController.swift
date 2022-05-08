import Foundation
import UIKit

class TabBarVC: UITabBarController{
    let moviesVC: UINavigationController! = nil
    let favoritesVC: UINavigationController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let moviesVC = UINavigationController(rootViewController: MovieListViewController())
        moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "ticket"), selectedImage: UIImage(systemName: "ticket.fill"))
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        self.setViewControllers([moviesVC, favoritesVC], animated: false)
    }
}
