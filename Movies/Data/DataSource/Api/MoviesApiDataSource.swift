//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Dániel Novák on 20/01/2024.
//

protocol MoviesApiDataSource {
    func getMovies() async throws -> [Movie]
    func getGenres() async throws -> [Genre]
    func getImagesConfiguration() async throws -> ImagesConfiguration
}
