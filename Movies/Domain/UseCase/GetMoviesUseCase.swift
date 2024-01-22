//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by Dániel Novák on 21/01/2024.
//

protocol GetMoviesUseCase {
    func getMovies() async throws -> [MovieVM]
}
