//
//  UIViewExtensions.swift
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

    func addShadow(color: UIColor = .black, offset: CGSize = CGSize(width: 2.0, height: 2.0), opacity: Float = 0.3, radius: CGFloat = 4.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }

}
