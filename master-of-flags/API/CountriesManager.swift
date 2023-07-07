import Combine
import Foundation

protocol CountriesManaging {
    func getCountries() -> AnyPublisher<[Country], Error>
}

final class CountriesManager: CountriesManaging {

    func getCountries() -> AnyPublisher<[Country], Error> {
        Just(Bundle.main.url(forResource: "countries", withExtension: "json"))
            .compactMap { $0 }
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: [Country].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

final class MockCountriesManager: CountriesManaging {
    
    func getCountries() -> AnyPublisher<[Country], Error> {
        Just([Country.mockCountry])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
