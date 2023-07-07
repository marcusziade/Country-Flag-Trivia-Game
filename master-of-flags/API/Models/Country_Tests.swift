import XCTest
import CoreLocation

@testable import Master_of_Flags

final class CountryTests: XCTestCase {
    
    var country: Country!
    
    override func setUp() {
        super.setUp()
        country = Country.mockCountry
    }
    
    override func tearDown() {
        country = nil
        super.tearDown()
    }
    
    func testID() {
        XCTAssertEqual(country.id, "Country name official")
    }
    
    func testLocation() {
        let expectedLocation = CLLocationCoordinate2D(latitude: 33.0, longitude: 65.0)
        assertCoordinateEqual(country.location, expectedLocation)
    }

    func testCountryLanguages() {
        XCTAssertEqual(country.countryLanguages, ["English"])
    }
    
    func testCountryCurrencies() {
        XCTAssertEqual(country.countryCurrencies, [Currency.mockCurrency.name, Currency.mockCurrency.name])
    }
    
    func testFlag() {
        let expectedURL = URL(string: "https://flagcdn.com/w320/my.png")
        XCTAssertEqual(country.flag, expectedURL)
    }
    
    func testGoogleMap() {
        let expectedURL = URL(string: "https://goo.gl/maps/qrY1PNeUXGyXDcPy6")
        XCTAssertEqual(country.googleMap, expectedURL)
    }
    
    func testOpenStreetMap() {
        let expectedURL = URL(string: "https://www.openstreetmap.org/relation/2108121")
        XCTAssertEqual(country.openStreetMap, expectedURL)
    }
    
    func testCapitalCity() {
        XCTAssertEqual(country.capitalCity, "Capital")
    }
    
    func testLessThan() {
        let otherCountry = Country.mockCountry
        XCTAssertTrue(country < otherCountry)
    }
    
    // MARK: Private
    
    private func assertCoordinateEqual(
        _ first: CLLocationCoordinate2D,
        _ second: CLLocationCoordinate2D,
        accuracy: CLLocationDegrees = 0.000001,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            abs(first.latitude - second.latitude) < accuracy &&
            abs(first.longitude - second.longitude) < accuracy,
            message(),
            file: file,
            line: line
        )
    }
}
