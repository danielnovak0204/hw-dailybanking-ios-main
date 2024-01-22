//
//  ImagesConfigurationWrapper.swift
//  Movies
//
//  Created by Dániel Novák on 20/01/2024.
//

struct ImagesConfigurationWrapper: Decodable {
    let imagesConfiguration: ImagesConfiguration
    
    private enum CodingKeys: String, CodingKey {
        case imagesConfiguration = "images"
    }
}
