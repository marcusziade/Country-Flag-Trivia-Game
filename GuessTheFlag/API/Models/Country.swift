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
    let population: Int
    private let latlng: [Double]?
    private let languages: [String : String]?
    private let flags: [String : URL]
    private let currencies: [String : Currency]?
    private let capital: [String]?
    private let maps: [String : URL]

    var id: String {
        name.official
    }

    var location: CLLocationCoordinate2D {
        guard let coordinates = latlng else { return CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384) }
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
        return flags.first { key, value in key.contains("png") }?.value
    }

    var googleMap: URL {
        return maps.first { key, value in key.contains("googleMaps") }?.value
        ?? URL(string: "https://goo.gl/maps/qrY1PNeUXGyXDcPy6")!
    }

    var openStreetMap: URL {
        return maps.first { key, value in key.contains("openStreetMaps") }?.value
        ?? URL(string: "https://www.openstreetmap.org/relation/2108121")!
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
            population: 144829202,
            latlng: [33.0, 65.0],
            languages: ["eng" : "English"],
            flags: ["png" : URL(string: "https://flagcdn.com/w320/my.png")!],
            currencies: ["USD" : Currency.mockCurrency, "EUR" : Currency.mockCurrency],
            capital: ["Capital"],
            maps: [
                "googleMaps" : URL(string: "https://goo.gl/maps/qrY1PNeUXGyXDcPy6")!,
                "openStreetMaps" : URL(string: "https://www.openstreetmap.org/relation/2108121")!
            ]
        )
    }
}

// MARK: - Comparable

extension Country: Comparable {
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
}
