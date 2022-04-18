import Foundation
import UIKit
import SnapKit

class MoviesCollectionView: UICollectionView{
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(){
        //create layout for CollectionView
        let flowLayout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        flowLayout.itemSize = CGSize(width: MovieListViewController.imageWidth, height: MovieListViewController.imageHeight)
        
        backgroundColor = .white
        
        snp.makeConstraints {
            $0.height.equalTo(MovieListViewController.imageHeight)
        }
    }
}
