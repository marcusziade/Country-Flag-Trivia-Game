//
//  Country.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import CoreLocation
import Foundation

struct Country: Codable, Identifiable {

    let name: Name
    let region: String
    private let latlng: [Double]?
    private let languages: [String : String]?
    private let flags: [URL]
    private let currencies: [String : Currency]?
    private let capital: [String]?

    var id: String {
        name.official
    }

    var location: CLLocationCoordinate2D? {
        guard let coordinates = latlng else { return nil }
        let latitude = coordinates.first!
        let longitude = coordinates.last!
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var countryLanguages: [String] {
        guard let languages = languages else { return [] }
        var values: [String] = []
        languages.forEach { values.append($1) }
        return values
    }

    var countryCurrencies: [String] {
        guard let currencies = currencies?.sorted(by: >) else { return [] }
        var values: [String] = []
        currencies.forEach { values.append($1.name) }
        return values
    }

    var flag: URL? {
        return flags.first(where: { $0.absoluteString.hasSuffix(".png") })
    }

    var capitalCity: String {
        return capital?.first ?? ""
    }
}

// MARK: - Mock data

extension Country {

    static var mockCountry: Country {
        return Country(
            name: Name(official: "Country name official", common: "Country"),
            region: "Sub-Region",
            latlng: [33.0, 65.0],
            languages: ["eng" : "English"],
            flags: [URL(string: "https://restcountries.com/data/png/fro.png")!],
            currencies: ["USD" : Currency.mockCurrency, "EUR" : Currency.mockCurrency],
            capital: ["Capital"]
        )
    }
}

extension Country: Comparable {
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
}
