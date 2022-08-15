
import Foundation

struct Constants {
    static let apiKEY = "884f05d8b26a893059e16c9b940e735c"
    static let baseURL = "https://api.themoviedb.org"
}
//MARK: - request from TMDb
class requestFromTMDb {
    func jsonRequest(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let urlString = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.apiKEY)&language=en-US&page=1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else { return }
                do {
                    let json = try JSONDecoder().decode(MoviesData.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
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
//MARK: - request from TMBd
class NetworkRequest {
    static let shared = NetworkRequest()
    
    private init() {}
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
}

