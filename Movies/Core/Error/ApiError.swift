//
//  ApiError.swift
//  Movies
//
//  Created by Dániel Novák on 20/01/2024.
//

enum ApiError: Error {
    case configuration
    case decoding
    case noConnection
    case request
    case unknown
}
