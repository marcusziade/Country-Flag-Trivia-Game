//
//  Configurable.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 21.11.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

public protocol Configurable {

    associatedtype T = Self
    func configure(_ work: (T) -> Void) -> T
}

public extension Configurable {

    @discardableResult
    func configure(_ work: (Self) -> Void) -> Self {
        work(self)
        return self
    }
}

extension NSObject: Configurable {}
