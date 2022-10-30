import Foundation

class FetchData {
    
    static let shared = FetchData()
    private init() {}
    
    func fetchStatistic(urlString: String, responce: @escaping (MoviesData?, Error?) -> Void ) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
                switch result {
                case .success(let data):
                    do {
                    let list = try JSONDecoder().decode(MoviesData.self, from: data)
                    responce(list, nil)
                
                    } catch let jsonError {
                        print("Fail to decode", jsonError)
                    }
                case .failure(let error):
                    print("erorr request: \(error.localizedDescription)")
                    responce(nil, error)
                }
        }
    }
}
