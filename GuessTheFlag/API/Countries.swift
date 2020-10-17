//
//  Countries.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation
import Combine

extension API {
        
    func getCountries() -> AnyPublisher<[Country], Error> {

        return get(path: "/region/europe", query: [], headers: [:])
            .decode(type: [Country].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
