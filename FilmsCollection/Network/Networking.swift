
import Foundation

struct Constants {
    static let apiKEY = "884f05d8b26a893059e16c9b940e735c"
    static let baseURL = "https://api.themoviedb.org"
}

//MARK: - request from TMBd
class NetworkRequest {
    static let shared = NetworkRequest()
    
     init() {}
    func requestData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
    
    func fetchImage(url:URL, completion: @escaping ((Data) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}

