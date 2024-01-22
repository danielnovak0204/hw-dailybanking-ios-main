//
//  MoviesRepositoryImplementation.swift
//  Movies
//
//  Created by Dániel Novák on 21/01/2024.
//

class MoviesRepositoryImplementation: MoviesRepository {
    private let dataSource: MoviesDataSource
    
    init(dataSource: MoviesDataSource) {
        self.dataSource = dataSource
    }
    
    func getMovies() async throws -> [MovieEntity] {
        let movies = try await dataSource.getMovies()
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
        let genres = try await dataSource.getGenres()
        return genres.map { genre in
            GenreEntity(id: genre.id, name: genre.name)
        }
    }
    
    func getImagesConfiguration() async throws -> ImagesConfigurationEntity {
        let imagesConfiguration = try await dataSource.getImagesConfiguration()
        return ImagesConfigurationEntity(
            baseUrl: imagesConfiguration.baseUrl,
            posterSizes: imagesConfiguration.posterSizes
        )
    }
}
