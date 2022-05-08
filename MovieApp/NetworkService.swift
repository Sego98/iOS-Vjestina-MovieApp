import Foundation
import UIKit

class NetworkService {
    enum RequestError: Error{
        case clientError
        case serverError
        case noData
        case dataDecodingError
    }
    
    struct Movie: Codable{
        let backdrop_path: String?
        let id: Int?
        let original_title: String?
        let overview: String?
    }
    
    struct Request: Codable{
        var results: [Movie]
    }

    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Request?, RequestError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, .clientError)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
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
      
            guard let value = try? JSONDecoder().decode(Request.self, from: data) else {
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
