import Foundation

enum GoogleAdIdentifiers {
    
    static let testID = "ca-app-pub-3940256099942544/2435281174"
    
    static var bottom_banner_country_detail: String {
#if targetEnvironment(simulator)
        return Self.testID
#else
        return "ca-app-pub-4478155005650262/6990357942"
#endif
    }
    
    static var top_banner_country_detail: String {
#if targetEnvironment(simulator)
        return Self.testID
#else
        return "ca-app-pub-4478155005650262/9074991038"
#endif
    }
    
    static var bottom_banner_flag_game: String {
#if targetEnvironment(simulator)
        return Self.testID
#else
        return "ca-app-pub-4478155005650262/1231256077"
#endif
    }
    
    static var top_banner_flag_game: String {
#if targetEnvironment(simulator)
        return Self.testID
#else
        return "ca-app-pub-4478155005650262/1229898839"
#endif
    }
}
