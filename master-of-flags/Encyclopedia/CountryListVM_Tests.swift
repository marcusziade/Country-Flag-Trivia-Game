import XCTest
import Combine

@testable import Master_of_Flags

final class CountryListVMTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()
    
    func testLoadCountries() {
        let mockManager = MockCountriesManager()
        let viewModel = CountryListVM(countriesManager: mockManager)
        
        let expectation = self.expectation(description: "Countries loaded")
        
        viewModel.$filteredCountries
            .receive(on: RunLoop.main)
            .sink { countries in
                print("Received countries: \(countries)")
                if !countries.isEmpty {
                    XCTAssertEqual(countries.first!.name.common, "Country")
                    expectation.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
