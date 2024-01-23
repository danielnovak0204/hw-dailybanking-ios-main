//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MoviesScreenViewModel: MoviesScreenViewModelProtocol {
    private enum Constants {
        static let configurationErrorMessage = "Configuration error"
        static let decodingErrorMessage = "Decoding error"
        static let noConnectionErrorMessage = "No connection"
        static let requestErrorMessage = "Request failed"
        static let unknownErrorMessage = "Unknown error"
    }
    
    @Published private(set) var movies = [MovieVM]()
    @Published var isFailed = false
    private(set) var errorMessage = ""
    private let getMoviesUseCase = Resolver.shared.resolve(GetMoviesUseCase.self)
    private let getFavouriteMoviesUseCase = Resolver.shared.resolve(GetFavouriteMoviesUseCase.self)
    
    func fetchMovies() async {
        isFailed = false
        errorMessage = ""
        do {
            movies = try await getMoviesUseCase.getMovies()
            updateFavouriteMovies()
        } catch {
            switch error {
            case ApiError.configuration: errorMessage = Constants.configurationErrorMessage
            case ApiError.decoding: errorMessage = Constants.decodingErrorMessage
            case ApiError.noConnection: errorMessage = Constants.noConnectionErrorMessage
            case ApiError.request: errorMessage = Constants.requestErrorMessage
            default: errorMessage = Constants.unknownErrorMessage
            }
            isFailed = true
        }
    }
    
    func updateFavouriteMovies() {
        let favouriteMovieIds = getFavouriteMoviesUseCase.getFavouriteMovies()
        var moviesList = movies
        for index in 0..<moviesList.count {
            moviesList[index].isMarked = favouriteMovieIds.contains(moviesList[index].id)
        }
        movies = moviesList
    }
}
