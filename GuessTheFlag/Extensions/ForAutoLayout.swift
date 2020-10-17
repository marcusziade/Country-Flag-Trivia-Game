//
//  ForAutoLayout.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import UIKit

extension UIView {
    
    func forAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints =  false
        return self
    }
}
