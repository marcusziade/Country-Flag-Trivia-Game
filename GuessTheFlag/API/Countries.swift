//
//  Countries.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation
import Combine

enum Region: String, CaseIterable {
    case europe = "Europe"
    case asia = "Asia"
    case africa = "Africa"
    case oceania = "Oceania"
    case americas = "Americas"
}

extension API {

    func getCountries(for region: Region) -> AnyPublisher<[Country], Error> {

        return get(path: "/region/\(region)", query: [], headers: [:])
            .decode(type: [Country].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
        
    func getEUCountries() -> AnyPublisher<[Country], Error> {

        return get(path: "/region/europe", query: [], headers: [:])
            .decode(type: [Country].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }

    func getAllCountries() -> AnyPublisher<[Country], Error> {
        return get(path: "", query: [], headers: [:])
            .decode(type: [Country].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
