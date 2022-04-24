//
//  UIViewExtensions.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// MARK: - For autolayout

extension UIView {
    
    func forAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints =  false
        return self
    }
}

// MARK: - Add shadow

extension UIView {
    
    func addShadow(color: UIColor = .black, offset: CGSize = CGSize(width: 2.0, height: 2.0), opacity: Float = 0.3, radius: CGFloat = 4.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}

// MARK: - Property Animator

extension UIView {
    
    // Fades a view in linearly with a given duration
    func fadeIn(duration: TimeInterval) {
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            self.alpha = 1
        }.startAnimation()
    }
    
    // Fades a view out linearly with a given duration
    func fadeOut(duration: TimeInterval) {
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            self.alpha = 0
        }.startAnimation()
    }
}

// MARK: - SnapKit Extensions

extension UIView {
    
    func addAndConstrainSubview(
        _ subview: UIView,
        at index: Int? = nil,
        _ makeConstraints: ((ConstraintMaker) -> Void)
    ) {
        if let index = index {
            insertSubview(subview, at: index)
        } else {
            addSubview(subview)
        }
        subview.snp.makeConstraints {
            makeConstraints($0)
        }
    }
}

// MARK: - Subview Extensions

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
