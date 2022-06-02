import Foundation
import UIKit

class MovieNetworkService {
    enum RequestError: Error{
        case clientError
        case serverError
        case noData
        case dataDecodingError
    }
    
    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Movie?, RequestError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, .clientError)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                DispatchQueue.main.async {
                completionHandler(nil, .serverError)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, .noData)
                }
                return
            }
      
            guard let value = try? JSONDecoder().decode(Movie.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(nil, .dataDecodingError)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(value, nil)
            }
        }
        dataTask.resume()
    }
}
