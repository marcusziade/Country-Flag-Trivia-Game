//
//  StoreKit+Ext.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 1.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import StoreKit

extension SKStoreReviewController {
    
    static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            requestReview(in: scene)
        }
    }
}
