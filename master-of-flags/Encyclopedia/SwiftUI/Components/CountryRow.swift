//
//  CountryRow.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 25.9.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Kingfisher
import SwiftUI

struct CountryRow: View {

    let country: Country

    var body: some View {
        HStack {
            KFImage(country.flag)
                .placeholder { ProgressView() }
                .resizable()
                .frame(width: 100, height: 50)
                .scaledToFit()

            VStack(alignment: .leading) {
                Text(country.name.common)
                    .font(.headline)
                Text(country.capitalCity)
                    .font(.subheadline)
            }
        }
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: Country.mockCountry)
            .previewLayout(.sizeThatFits)
    }
}
