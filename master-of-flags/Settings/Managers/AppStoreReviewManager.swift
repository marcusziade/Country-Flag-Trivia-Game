import Foundation
import StoreKit

enum AppStoreReviewManager {

    static func requestReview() {
        SKStoreReviewController.requestReviewInCurrentScene()
    }
}


