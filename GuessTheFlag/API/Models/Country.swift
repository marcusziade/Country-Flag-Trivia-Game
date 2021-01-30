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
    let timezones: [String]
    let borders: [String]
    let nativeName: String
    let flag: URL
    let currencies: [Currency]
    let languages: [Language]

    static func generateMockCountry() -> Country {
        return Country(
            name: "Country",
            capital: "Capital",
            subregion: "Sub-Region",
            population: 4000400,
            latlng: [33.0, 65.0],
            demonym: "Demonym",
            timezones: ["UTC+04:30"],
            borders: ["IRN", "PAK", "TKM", "UZB", "TJK", "CHN"],
            nativeName: "Native name",
            flag: URL(string: "https://restcountries.eu/data/afg.svg")!,
            currencies: Currency.generateMockCurrencies(),
            languages: Language.generateMockLanguages()
        )
    }
}
