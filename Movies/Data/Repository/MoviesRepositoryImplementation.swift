//
//  MoviesRepositoryImplementation.swift
//  Movies
//
//  Created by Dániel Novák on 21/01/2024.
//

class MoviesRepositoryImplementation: MoviesRepository {
    private let apiDataSource: MoviesApiDataSource
    
    init(apiDataSource: MoviesApiDataSource) {
        self.apiDataSource = apiDataSource
    }
    
    func getMovies() async throws -> [MovieEntity] {
        let movies = try await apiDataSource.getMovies()
        return movies.map { movie in
            MovieEntity(
                id: movie.id,
                title: movie.title,
                genreIds: movie.genreIds,
                overview: movie.overview,
                posterPath: movie.posterPath,
                popularity: movie.popularity
            )
        }
    }
    
    func getGenres() async throws -> [GenreEntity] {
        let genres = try await apiDataSource.getGenres()
        return genres.map { genre in
            GenreEntity(id: genre.id, name: genre.name)
        }
    }
    
    func getImagesConfiguration() async throws -> ImagesConfigurationEntity {
        let imagesConfiguration = try await apiDataSource.getImagesConfiguration()
        return ImagesConfigurationEntity(
            baseUrl: imagesConfiguration.baseUrl,
            posterSizes: imagesConfiguration.posterSizes
        )
    }
}
