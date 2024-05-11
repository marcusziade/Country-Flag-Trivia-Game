import MapKit
import SwiftUI

struct CountryDetailMapView: View {
    let country: Country
    @ObservedObject var viewModel: CountryDetailVM
    
    var body: some View {
        VStack(spacing: 8) {
            Map(
                coordinateRegion: $viewModel.region, 
                showsUserLocation: false, 
                userTrackingMode: .none, 
                annotationItems: [viewModel.country]
            ) { country in
                MapMarker(
                    coordinate: CLLocationCoordinate2D(latitude: country.latlng![0], longitude: country.latlng![1]), 
                    tint: .red
                )
            }
            .frame(height: 200)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Link(destination: country.googleMap) {
                        Label("Google Maps", systemImage: "map")
                            .modifier(LinkLabelStyle())
                    }

                    Link(destination: country.openStreetMap) {
                        Label("Open Street Map", systemImage: "map")
                            .modifier(LinkLabelStyle())
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}
