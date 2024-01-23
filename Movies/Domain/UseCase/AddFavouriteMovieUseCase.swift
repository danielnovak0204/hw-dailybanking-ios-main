//
//  AddFavouriteMovieUseCase.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

protocol AddFavouriteMovieUseCase {
    func addFavouriteMovie(id: String)
}

class AddFavouriteMovieUseCaseImplementation: AddFavouriteMovieUseCase {
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func addFavouriteMovie(id: String) {
        repository.addFavouriteMovie(id: id)
    }
}
