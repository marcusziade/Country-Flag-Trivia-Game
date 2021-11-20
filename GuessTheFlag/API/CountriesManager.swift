//
//  CountriesManager.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation
import Combine

final class CountriesManager {

    func getCountries() -> AnyPublisher<[Country], Error> {
        Just(Bundle.main.url(forResource: "countries", withExtension: "json"))
            .compactMap { $0 }
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: [Country].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
