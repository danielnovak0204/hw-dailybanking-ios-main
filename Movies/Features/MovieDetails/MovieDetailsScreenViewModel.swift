//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MovieDetailsScreenViewModel: MovieDetailsScreenViewModelProtocol {
    @Published private(set) var movie: MovieVM
    private let addFavouriteMovieUseCase = Resolver.shared.resolve(AddFavouriteMovieUseCase.self)
    private let removeFavouriteMovieUseCase = Resolver.shared.resolve(RemoveFavouriteMovieUseCase.self)

    init(movie: MovieVM) {
        self.movie = movie
    }

    func markMovie() {
        if movie.isMarked {
            removeFavouriteMovieUseCase.removeFavouriteMovie(id: movie.id)
        } else {
            addFavouriteMovieUseCase.addFavouriteMovie(id: movie.id)
        }
        movie.isMarked.toggle()
    }
}
