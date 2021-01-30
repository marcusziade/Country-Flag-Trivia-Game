//
//  Country.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation

struct Country: Codable {
    
    // MARK: - Properties
    let name: String
    let capital: String
    let flag: URL
}
