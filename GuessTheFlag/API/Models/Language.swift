//
//  Language.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

struct Language: Codable, Hashable {

    // MARK: - Properties
    
    let name: String
    let nativeName: String

    static func generateMockLanguages() -> [Language] {
        return (0...3).map { index -> Language in
            return Language(name: "Language", nativeName: "Native Name")
        }
    }
}
