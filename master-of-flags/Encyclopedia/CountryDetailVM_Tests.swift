import XCTest
import MapKit

@testable import Master_of_Flags

final class CountryDetailVM_Tests: XCTestCase {
    var countryDetailVM: CountryDetailVM!
    let mockCountry = Country.mockCountry
    
    override func setUp() {
        super.setUp()
        countryDetailVM = CountryDetailVM(country: mockCountry)
    }
    
    override func tearDown() {
        countryDetailVM = nil
        super.tearDown()
    }
    
    func testRegionInit() {
        let expectedRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: mockCountry.latlng![0], longitude: mockCountry.latlng![1]),
            span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        )
        XCTAssertEqual(countryDetailVM.region.center.latitude, expectedRegion.center.latitude, accuracy: 0.0001)
        XCTAssertEqual(countryDetailVM.region.center.longitude, expectedRegion.center.longitude, accuracy: 0.0001)
        XCTAssertEqual(countryDetailVM.region.span.latitudeDelta, expectedRegion.span.latitudeDelta, accuracy: 0.0001)
        XCTAssertEqual(countryDetailVM.region.span.longitudeDelta, expectedRegion.span.longitudeDelta, accuracy: 0.0001)
    }
    
    func testCountryInit() {
        XCTAssertEqual(countryDetailVM.country, mockCountry)
    }
    
    func testWikipediaURL() {
        let expectedURL = URL(string: "https://en.wikipedia.org/wiki/\(mockCountry.name.common)")
        XCTAssertEqual(countryDetailVM.wikipediaURL, expectedURL)
    }
}
