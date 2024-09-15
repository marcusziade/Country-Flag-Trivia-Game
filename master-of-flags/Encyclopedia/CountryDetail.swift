import MapKit
import SwiftUI

struct CountryDetail: View {
    
    @StateObject var viewModel: CountryDetailVM
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: viewModel.country.flag) {
                    $0.image?
                        .resizable()
                        .frame(height: 250)
                }

                // test id
                GoogleAdBannerView(unitID: GoogleAdIdentifiers.top_banner_country_detail)
                    .frame(height: 50)

                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text(viewModel.country.name.official)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        DetailSection(header: "Capital") { Text(viewModel.country.capitalCity) }
                        DetailSection(header: "Region") { Text(viewModel.country.region) }
                        DetailSection(header: "Population") { Text("\(viewModel.country.population)") }
                        
                        DetailSection(header: "Currencies") {
                            ForEach(viewModel.country.countryCurrencies, id: \.self) { Text($0) }
                        }
                        
                        DetailSection(header: "Languages") {
                            ForEach(viewModel.country.countryLanguages, id: \.self) { Text($0) }
                        }
                        
                        if let url = viewModel.wikipediaURL {
                            Link(destination: url) {
                                Text("Study on Wikipedia")
                                    .modifier(LinkLabelStyle())
                            }
                            .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                    
                    CountryDetailMapView(country: viewModel.country, viewModel: viewModel)
                }
                Spacer()

                // test id
                GoogleAdBannerView(unitID: GoogleAdIdentifiers.bottom_banner_country_detail)
                    .frame(height: 50)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailSection<Content: View>: View {
    let header: String
    let content: Content
    
    init(header: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header).font(.headline).foregroundColor(.accentColor)
            content
        }
    }
}
