//
//  RemoveFavouriteMovieUseCase.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

protocol RemoveFavouriteMovieUseCase {
    func removeFavouriteMovie(id: String)
}

class RemoveFavouriteMovieUseCaseImplementation: RemoveFavouriteMovieUseCase {
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func removeFavouriteMovie(id: String) {
        repository.removeFavouriteMovie(id: id)
    }
}
