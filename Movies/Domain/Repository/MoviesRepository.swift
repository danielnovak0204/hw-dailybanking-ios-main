//
//  MoviesRepository.swift
//  Movies
//
//  Created by Dániel Novák on 21/01/2024.
//

protocol MoviesRepository {
    func getMovies() async throws -> [MovieEntity]
    func getGenres() async throws -> [GenreEntity]
    func getImagesConfiguration() async throws -> ImagesConfigurationEntity
}
