//
//  Name.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 25.9.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

struct Name: Codable, Hashable, Comparable {
    static func < (lhs: Name, rhs: Name) -> Bool {
        lhs.common == rhs.common
    }

    let official: String
    let common: String
}
