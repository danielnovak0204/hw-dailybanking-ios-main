//
//  MoviesRepositoryImplementation.swift
//  Movies
//
//  Created by Dániel Novák on 21/01/2024.
//

class MoviesRepositoryImplementation: MoviesRepository {
    private let apiDataSource: MoviesApiDataSource
    private let localDataSource: MoviesLocalDataSource
    
    init(apiDataSource: MoviesApiDataSource, localDataSource: MoviesLocalDataSource) {
        self.apiDataSource = apiDataSource
        self.localDataSource = localDataSource
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
                voteAverage: movie.voteAverage
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
    
    func getFavouriteMovies() -> [String] {
        localDataSource.getFavouriteMovies()
    }
    
    func addFavouriteMovie(id: String) {
        localDataSource.addFavouriteMovie(id: id)
    }
    
    func removeFavouriteMovie(id: String) {
        localDataSource.removeFavouriteMovie(id: id)
    }
}
