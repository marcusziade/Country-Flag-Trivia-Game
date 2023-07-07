import XCTest

@testable import Master_of_Flags

final class CountriesManagerTests: XCTestCase {
    
    func testGetCountries() {
        let manager = CountriesManager()
        let expectation = XCTestExpectation(description: "Countries fetched")
        
        _ = manager.getCountries().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Failed to get countries: \(error)")
            case .finished:
                expectation.fulfill()
            }
        }, receiveValue: { countries in
            XCTAssertFalse(countries.isEmpty, "No countries fetched")
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
}
