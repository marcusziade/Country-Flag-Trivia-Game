//
//  API.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation
import Combine

class API {
    
    // MARK: - Types
    enum APIError: Error {
        case invalidResponse
        case statusCode(Int)
    }
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://restcountries.eu/rest/v2")!
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        let session = URLSession(configuration: config)
        return session
    }()
    
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Methods
    private func buildURL(path: String, query: [URLQueryItem]?) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = query
        return components.url!
    }
    
    private func request(method: HTTPMethod, path: String, query: [URLQueryItem]?, body: Data?, headers: [String : String]) -> AnyPublisher<Data, Error> {
        
        let url = buildURL(path: path, query: query)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = body
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let httpResponse = $0.response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.statusCode(httpResponse.statusCode)
                }
                return $0.data
            }
            .eraseToAnyPublisher()
    }
    
    func get(path: String, query: [URLQueryItem], headers: [String : String]) -> AnyPublisher<Data, Error> {
        return request(method: .get, path: path, query: query, body: nil, headers: headers)
    }
}
