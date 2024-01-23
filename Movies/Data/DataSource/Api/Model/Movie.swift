//
//  Movie.swift
//  Movies
//
//  Created by Dániel Novák on 20/01/2024.
//

struct Movie: Decodable {
    let id: Int
    let title: String
    let genreIds: [Int]
    let overview: String
    let posterPath: String
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genreIds = "genre_ids"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
