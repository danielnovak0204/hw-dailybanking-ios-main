//
//  MoviesLocalDataSource.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

protocol MoviesLocalDataSource {
    func getFavouriteMovies() -> [String]
    func addFavouriteMovie(id: String)
    func removeFavouriteMovie(id: String)
}
