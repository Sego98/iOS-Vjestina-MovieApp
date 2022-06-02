
struct Movie: Codable{
    let backdrop_path: String?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Float?
    let poster_path: String?
    let release_date: String?
    let runtime: Int?
    let title: String?
    let video: Bool?
    let vote_average: Float?
    let vote_count: Int?
    let production_countries: [Country?]
    let genres: [Genre?]
}

struct Country: Codable{
    let iso_3166_1: String?
    let name: String?
}

struct Genre: Codable, Equatable{
    let id: Int?
    let name: String?
}
