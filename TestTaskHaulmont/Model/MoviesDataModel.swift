
import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let backdropImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case backdropImage = "backdrop_path"
    }
    
    //MARK: - Convert to normal date format
     func convertDataFormat(_ date: String?) -> String {
        var dateOutput = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateInput = date {
            if let newDate = dateFormatter.date(from: dateInput) {
                dateFormatter.dateFormat = "d.MM.yyyy"
                dateOutput = dateFormatter.string(from: newDate)
            }
        }
        return dateOutput
    }
}


