//
//  ImagesConfiguration.swift
//  Movies
//
//  Created by Dániel Novák on 20/01/2024.
//

struct ImagesConfiguration: Decodable {
    let baseUrl: String
    let posterSizes: [String]
    
    private enum CodingKeys: String, CodingKey {
        case baseUrl = "secure_base_url"
        case posterSizes = "poster_sizes"
    }
}
