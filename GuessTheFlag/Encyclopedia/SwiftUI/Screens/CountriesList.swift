//
//  CountriesList.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 25.9.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import SwiftUI

struct CountriesList: View {
    var body: some View {
        NavigationView {
            List(viewModel.filteredCountries) { country in
                NavigationLink(destination: CountryDetail(country: country))
                    { CountryRow(country: country) }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker(selection: $viewModel.selectedRegion, label: Text("Picker")) {
                        ForEach(0..<Region.allCases.count) {
                            Text(Region.allCases[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: viewModel.selectedRegion) { _ in
                        UIImpactFeedbackGenerator().impactOccurred()
                    }
                }
            }
        }
    }

    // MARK: - Private

    @StateObject var viewModel = CountryListVM()
}

struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountriesList(viewModel: CountryListVM())
            .preferredColorScheme(.dark)
    }
}
