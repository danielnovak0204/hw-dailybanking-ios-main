//
//  Container+Data.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

extension Container {
    func withDataComponents() -> Self {
        register(MoviesApiDataSource.self) { _ in
            MoviesApiDataSourceImplementation()
        }
        register(MoviesLocalDataSource.self) { _ in
            MoviesLocalDataSourceImplementation()
        }
        return self
    }
}
