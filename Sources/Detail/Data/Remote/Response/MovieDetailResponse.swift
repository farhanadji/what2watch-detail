//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Core

public struct MovieDetailResponse: Decodable {
    let id: Int?
    let posterPath: String?
    let backdropPath: String?
    let title: String?
    let overview: String?
    let releaseDate: String?
    let genres: [MovieGenre]?
    let status: String?
    let genresString: String
    let voteAverage: Double?
    let vouteCount: Int?
    let popularity: Double?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let posterPath = try container.decode(String?.self, forKey: .posterPath)
        self.id = try container.decode(Int?.self, forKey: .id)
        self.posterPath = "\(API.imageUrl)\(posterPath ?? "")"
        let backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        self.backdropPath = "\(API.imageUrl)\(backdropPath ?? "")"
        title = try container.decode(String?.self, forKey: .title)
        overview = try container.decode(String?.self, forKey: .overview)
        
        let date = try container.decode(String?.self, forKey: .releaseDate)
        if let year = date?.split(separator: "-")[0] {
            self.releaseDate = String(year)
        } else {
            self.releaseDate = "-"
        }
        
        genres = try container.decode([MovieGenre]?.self, forKey: .genres)
        if let genresData = genres {
            var genreTemp: [String] = []
            _ = genresData.map { data in
                genreTemp.append(data.name ?? "")
            }
            genresString = genreTemp.joined(separator: ", ")
        } else {
            genresString = "-"
        }
        status = try container.decode(String?.self, forKey: .status)
        popularity = try container.decode(Double?.self, forKey: .popularity)
        voteAverage = try container.decode(Double?.self, forKey: .voteAverage)
        vouteCount = try container.decode(Int?.self, forKey: .voteCount)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case overview
        case releaseDate = "release_date"
        case genres
        case status
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



public struct MovieGenre: Decodable {
    let name: String?
}


