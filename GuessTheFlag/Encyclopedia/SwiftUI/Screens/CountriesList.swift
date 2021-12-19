//
//  CountriesList.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 25.9.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import CoreLocation
import SwiftUI

struct CountriesList: View {
    
    @StateObject var viewModel: CountryListVM
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredCountries) { country in
                NavigationLink(destination: CountryDetail(
                    viewModel: CountryDetailVM(coordinate: country.location),
                    country: country
                ))
                { CountryRow(country: country) }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker(selection: $viewModel.selectedRegion, label: Text("Picker")) {
                        ForEach(0..<viewModel.regions.count) {
                            Text(viewModel.regions[$0].title)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountriesList(viewModel: CountryListVM())
            .preferredColorScheme(.dark)
    }
}
