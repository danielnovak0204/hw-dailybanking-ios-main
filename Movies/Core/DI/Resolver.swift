//
//  Resolver.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

final class Resolver {
    static let shared = Resolver()
    private var container: Container!
    
    private init() { }
    
    func resolve<Service>(_ type: Service.Type) -> Service {
        ensureContainer()
        return container.resolve(type.self)!
    }
    
    private func ensureContainer() {
        if container == nil {
            container = Container()
            container.register(MoviesApiDataSource.self) { _ in
                MoviesApiDataSourceImplementation()
            }
            container.register(MoviesRepository.self) {
                MoviesRepositoryImplementation(apiDataSource: $0.resolve(MoviesApiDataSource.self)!)
            }
            container.register(GetMoviesUseCase.self) {
                GetMoviesUseCaseImplementation(repository: $0.resolve(MoviesRepository.self)!)
            }
        }
    }
}
