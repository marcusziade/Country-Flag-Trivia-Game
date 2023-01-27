import Combine
import Foundation

final class CountriesManager {

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


