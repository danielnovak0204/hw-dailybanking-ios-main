//
//  Container+Domain.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

extension Container {
    func withDomainComponents() -> Self {
        register(MoviesRepository.self) {
            MoviesRepositoryImplementation(
                apiDataSource: $0.resolve(MoviesApiDataSource.self)!,
                localDataSource: $0.resolve(MoviesLocalDataSource.self)!
            )
        }
        register(GetMoviesUseCase.self) {
            GetMoviesUseCaseImplementation(repository: $0.resolve(MoviesRepository.self)!)
        }
        register(GetFavouriteMoviesUseCase.self) {
            GetFavouriteMoviesUseCaseImplementation(repository: $0.resolve(MoviesRepository.self)!)
        }
        register(AddFavouriteMovieUseCase.self) {
            AddFavouriteMovieUseCaseImplementation(repository: $0.resolve(MoviesRepository.self)!)
        }
        register(RemoveFavouriteMovieUseCase.self) {
            RemoveFavouriteMovieUseCaseImplementation(repository: $0.resolve(MoviesRepository.self)!)
        }
        return self
    }
}
