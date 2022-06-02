import Foundation
import CoreData

class MoviesDatabaseDataSource{
    /*
     I didn't manage to do much. The idea of CoreData is clear to me, I have some problems with writing functions to fetch/delete data.
     That is the reason why I didn't solve this homework to the end.
     I hope that the review will help me to understand it completely.
     */
    
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
    
 /*   private func deleteAllMoviesExcept(withId ids: [Int]) {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "NOT %K IN %@", #keyPath(MovieEntity.id), ids)
        
        do{
            let moviesToDelete = try coreDataContext.fetch(request)
            moviesToDelete.forEach{coreDataContext.delete($0)}
        } catch let error as NSError{
            print(error)
        }
    } */
    
 /*   private func fetchMovie(withId id: Int) -> MovieEntity? {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(MovieEntity.id), id)

        do{
            let cdResponse = try coreDataContext.fetch(request)
            return cdResponse.first
        } catch let error as NSError{
            print(error)
       
    }*/
    
   /* func deleteMovie(withId id: Int) {
        guard let movie = try? fetchMovie(withId: id) else { return }
        coreDataContext.delete(movie)

        do {
            try coreDataContext.save()
        } catch {
            print(error)
        }
    } */
    
    func fetchMovies() -> [MovieEntity] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            let results = try coreDataContext.fetch(request)
            return results
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }
}
