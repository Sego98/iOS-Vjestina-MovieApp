import Foundation
import CoreData

class MoviesDatabaseDataSource {
    
    private let coreDataContext: NSManagedObjectContext
    
    static var movies = [NSManagedObject]()
    
    init(coreDataContext: NSManagedObjectContext){
        self.coreDataContext = coreDataContext
    }
    
    func saveMovie(id: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: coreDataContext)!
        let movie = NSManagedObject(entity: entity, insertInto: coreDataContext)
        movie.setValue(id, forKeyPath: "id")
        do {
            try coreDataContext.save()
            MoviesDatabaseDataSource.movies.append(movie)
            print(MoviesDatabaseDataSource.movies.count)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
