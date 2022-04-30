//
//  AppStoreReviewManager.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    
    static func requestReview() {
        SKStoreReviewController.requestReview()
    }
}
