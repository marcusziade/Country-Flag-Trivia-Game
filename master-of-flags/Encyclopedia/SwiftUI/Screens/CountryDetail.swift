import Kingfisher
import MapKit
import SwiftUI

struct CountryDetail: View {

    @StateObject var viewModel: CountryDetailVM

    let country: Country

    var body: some View {
        VStack {
            KFImage(country.flag)
                .placeholder { ProgressView() }
                .resizable()
                .frame(height: 250)

            Form {
                Text(country.name.official).font(.title)
                Section(header: Text("Capital")) {
                    Text(country.capitalCity)
                }

                Section(header: Text("Region")) {
                    Text(country.region)
                }

                Section(header: Text("Currencies")) {
                    ForEach(country.countryCurrencies, id: \.self) { Text($0) }
                }

                Section(header: Text("Population")) {
                    Text("\(country.population)")
                }

                Section(header: Text("Languages")) {
                    ForEach(country.countryLanguages, id: \.self) { Text($0) }
                }

                if let url = URL(string: "https://en.wikipedia.org/wiki/\(country.name.common)") {
                    Link(destination: url) {
                        Text("Study on Wikipedia")
                            .foregroundColor(.blue)
                    }
                }

                Section(header: Text("Maps")) {
                    NavigationLink(
                        destination: Map(coordinateRegion: $viewModel.region).edgesIgnoringSafeArea(.all)
                    ) {
                        Label("Apple Maps", systemImage: "map")
                    }
                    Link(destination: country.googleMap) {
                        Label("Google Maps", systemImage: "map")
                    }
                    Link(destination: country.openStreetMap) {
                        Label("Open Street Map", systemImage: "map")
                    }
                }
                .foregroundColor(.blue)
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct CountryDetail_Previews: PreviewProvider {

    static var previews: some View {
        CountryDetail(
            viewModel: CountryDetailVM(coordinate: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384)),
            country: Country.mockCountry
        )
    }
}


