//
//  MoviesApiDataSourceImplementation.swift
//  Movies
//
//  Created by Dániel Novák on 20/01/2024.
//

import Foundation

class MoviesApiDataSourceImplementation: MoviesApiDataSource {
    private enum Constants {
        static let apiKey = APIkey
        static let apiBaseUrl = "https://api.themoviedb.org/3"
        static let moviesUrlPath = "/trending/movie/day"
        static let genresUrlPath = "/genre/movie/list"
        static let imagesConfigurationPath = "/configuration"
        static let isoLanguageQueryParameterValue = "en-US"
        static let languageQueryParameterValue = "en"
        static let acceptHeaderParameterValue = "application/json"
        static let requestTimeout = 10.0
    }
    
    private let urlSession: URLSession
    
    private var requestBuilder: RequestBuilder {
        RequestBuilder(baseUrl: Constants.apiBaseUrl, urlSession: urlSession)
            .withQueryParameter(key: .apiKey, value: Constants.apiKey)
            .withHeaderParameter(key: .accept, value: Constants.acceptHeaderParameterValue)
            .withTimeout(Constants.requestTimeout)
    }
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getMovies() async throws -> [Movie] {
        let moviesWrapper: MoviesWrapper = try await requestBuilder
            .withType(.get)
            .withUrlPath(Constants.moviesUrlPath)
            .withQueryParameter(key: .language, value: Constants.isoLanguageQueryParameterValue)
            .request()
        return moviesWrapper.results
    }
    
    func getGenres() async throws -> [Genre] {
        let genresWrapper: GenresWrapper = try await requestBuilder
            .withType(.get)
            .withUrlPath(Constants.genresUrlPath)
            .withQueryParameter(key: .language, value: Constants.languageQueryParameterValue)
            .request()
        return genresWrapper.genres
    }
    
    func getImagesConfiguration() async throws -> ImagesConfiguration {
        let imagesConfigurationWrapper: ImagesConfigurationWrapper = try await requestBuilder
            .withType(.get)
            .withUrlPath(Constants.imagesConfigurationPath)
            .request()
        return imagesConfigurationWrapper.imagesConfiguration
    }
}

private enum HTTPMethod: String {
    case get = "GET"
}

private enum QueryKey: String {
    case apiKey = "api_key"
    case language
}

private enum HeaderKey: String {
    case accept
}

private class RequestBuilder {
    private let urlSession: URLSession
    private let baseUrl: String
    private var type = HTTPMethod.get
    private var queryParameters = [QueryKey: String]()
    private var headerParameters = [HeaderKey: String]()
    private var urlPath: String?
    
    private var urlRequest: URLRequest {
        get throws {
            guard let urlPath, var urlComponents = URLComponents(string: "\(baseUrl)\(urlPath)") else {
                throw ApiError.configuration
            }
            urlComponents.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key.rawValue, value: value)
            }
            guard let url = urlComponents.url else {
                throw ApiError.configuration
            }
            var request = URLRequest(url: url)
            request.httpMethod = type.rawValue
            headerParameters.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key.rawValue)
            }
            return request
        }
    }
    
    init(baseUrl: String, urlSession: URLSession) {
        self.baseUrl = baseUrl
        self.urlSession = urlSession
    }
    
    func withUrlPath(_ urlPath: String) -> Self {
        self.urlPath = urlPath
        return self
    }

    func withType(_ type: HTTPMethod) -> Self {
        self.type = type
        return self
    }

    func withTimeout(_ timeout: Double) -> Self {
        urlSession.configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        return self
    }

    func withQueryParameter(key: QueryKey, value: String) -> Self {
        queryParameters[key] = value
        return self
    }

    func withQueryParameters(_ queryParameters: [QueryKey: String]) -> Self {
        self.queryParameters = queryParameters
        return self
    }

    func withHeaderParameter(key: HeaderKey, value: String) -> Self {
        headerParameters[key] = value
        return self
    }

    func withHeaderParameters(_ headerParameters: [HeaderKey: String]) -> Self {
        self.headerParameters = headerParameters
        return self
    }
    
    func request<T: Decodable>() async throws -> T {
        do {
            let (data, response) = try await urlSession.data(for: try urlRequest)
            try validateResponse(response)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error.asApiError
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        if (response as? HTTPURLResponse)?.statusCode == 200 {
            return
        }
        throw ApiError.request
    }
}

private extension Error {
    var asApiError: ApiError {
        if let apiError = self as? ApiError {
            return apiError
        } else if self is DecodingError {
            return ApiError.decoding
        } else if self.isNoConnection {
            return ApiError.noConnection
        } else {
            return ApiError.unknown
        }
    }
    
    private var isNoConnection: Bool {
        if let errorCode = (self as? URLError)?.errorCode {
            return errorCode == NSURLErrorNotConnectedToInternet || errorCode == NSURLErrorDataNotAllowed
        }
        return false
    }
}
