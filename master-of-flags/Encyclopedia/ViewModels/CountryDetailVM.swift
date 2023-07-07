import Combine
import CoreLocation
import Foundation
import MapKit

final class CountryDetailVM: ObservableObject {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
        span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
    )
    var country: Country
    var wikipediaURL: URL? {
        URL(string: "https://en.wikipedia.org/wiki/\(country.name.common)")
    }
    
    init(country: Country) {
        self.country = country
        region = MKCoordinateRegion(
            center: country.location,
            span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        )
    }
}
