//
//  Country.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation

struct Country: Codable, Hashable {
    
    // MARK: - Properties
    let name: String
    let capital: String
    let subregion: String
    let population: Int
    let latlng: [Double]
    let demonym: String
    let timezones: String
    let borders: [String]
    let activeName: String
    let flag: URL
    let currencies: [Currency]
    let languages: [Language]
}

struct Currency: Codable, Hashable {
    let code: String
    let name: String
    let symbol: String
}

struct Language: Codable, Hashable {
    let name: String
    let nativeName: String
}
