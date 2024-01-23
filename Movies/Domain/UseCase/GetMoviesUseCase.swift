//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by Dániel Novák on 21/01/2024.
//

protocol GetMoviesUseCase {
    func getMovies() async throws -> [MovieVM]
}

class GetMoviesUseCaseImplementation: GetMoviesUseCase {
    private enum Constants {
        static let smallPosterSize = "w185"
        static let largePosterSize = "w500"
        static let posterSizeFallback = "original"
    }
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func getMovies() async throws -> [MovieVM] {
        async let movies = repository.getMovies()
        async let genres = repository.getGenres()
        async let imagesConfiguration = repository.getImagesConfiguration()
        let results = try await (movies: movies, genres: genres, imagesConfiguration: imagesConfiguration)
        return results.movies.map { movie in
            MovieVM(
                id: String(movie.id),
                title: movie.title,
                genres: mapGenres(results.genres, by: movie.genreIds),
                overView: movie.overview,
                image: mapPosterPath(movie.posterPath, by: results.imagesConfiguration),
                popularity: movie.popularity,
                isMarked: false
            )
        }
    }
    
    private func mapGenres(_ genres: [GenreEntity], by genreIds: [Int]) -> String {
        genreIds
            .compactMap { id in
                genres.first(where: { $0.id == id })?.name
            }
            .sorted()
            .joined(separator: ", ")
    }
    
    private func mapPosterPath(
        _ posterPath: String,
        by imagesConfiguration: ImagesConfigurationEntity
    ) -> MovieVM.Image {
        let smallPosterSize = imagesConfiguration.posterSizes.first {
            $0 == Constants.smallPosterSize
        } ?? Constants.posterSizeFallback
        let largePosterSize = imagesConfiguration.posterSizes.first {
            $0 == Constants.largePosterSize
        } ?? Constants.posterSizeFallback
        return MovieVM.Image(
            small: imagesConfiguration.baseUrl + smallPosterSize + posterPath,
            large: imagesConfiguration.baseUrl + largePosterSize + posterPath
        )
    }
}
