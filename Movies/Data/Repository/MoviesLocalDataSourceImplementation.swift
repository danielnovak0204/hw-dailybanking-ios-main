//
//  MoviesLocalDataSourceImplementation.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

class MoviesLocalDataSourceImplementation: MoviesLocalDataSource {
    private var favouriteMovies = Set<String>()
    
    func getFavouriteMovies() -> [String] {
        Array(favouriteMovies)
    }
    
    func addFavouriteMovie(id: String) {
        favouriteMovies.insert(id)
    }
    
    func removeFavouriteMovie(id: String) {
        favouriteMovies.remove(id)
    }
}
