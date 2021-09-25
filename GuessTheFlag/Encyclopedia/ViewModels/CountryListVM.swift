//
//  CountryListVM.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 25.9.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Combine
import Foundation

final class CountryListVM: ObservableObject {

    @Published var filteredCountries: [Country] = []
    @Published var selectedRegion: Int = 0

    init() {
        loadCountries()

        $selectedRegion
            .removeDuplicates()
            .sink { [unowned self] in
                switch $0 {
                case 0: filteredCountries   = filterAndSort(countries, .europe)
                case 1: filteredCountries   = filterAndSort(countries, .asia)
                case 2: filteredCountries   = filterAndSort(countries, .africa)
                case 3: filteredCountries   = filterAndSort(countries, .oceania)
                default: filteredCountries  = filterAndSort(countries, .americas)
                }
            }.store(in: &subscriptions)
    }

    // MARK: - Private

    private let api = API()
    private var subscriptions = Set<AnyCancellable>()
    private var countries: [Country] = []

    private func loadCountries() {
        api.getCountries()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] in
                countries = $0
                filteredCountries = filterAndSort(countries, .europe)
            }
            .store(in: &subscriptions)
    }

    private func filterAndSort(_ countries: [Country], _ region: Region) -> [Country] {
        return countries
            .filter { $0.region == region.rawValue }
            .sorted { $0.name.common < $1.name.common }
    }
}
