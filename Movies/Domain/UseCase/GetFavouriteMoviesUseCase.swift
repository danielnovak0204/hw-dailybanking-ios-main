//
//  GetFavouriteMoviesUseCase.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

protocol GetFavouriteMoviesUseCase {
    func getFavouriteMovies() -> [String]
}

class GetFavouriteMoviesUseCaseImplementation: GetFavouriteMoviesUseCase {
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func getFavouriteMovies() -> [String] {
        repository.getFavouriteMovies()
    }
}
