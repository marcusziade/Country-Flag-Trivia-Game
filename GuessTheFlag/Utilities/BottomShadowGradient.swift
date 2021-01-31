//
//  BottomShadowGradient.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit

class BottomShadowGradient: UIView {
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()!
        let gradientColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7089041096)
        let gradientColor2 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        let gradient = CGGradient(colorsSpace: nil, colors: [gradientColor2.cgColor, gradientColor.cgColor] as CFArray, locations: [0.6, 1.0])!
        let rectangleRect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        let rectanglePath = UIBezierPath(rect: rectangleRect)
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient,
            start: CGPoint(x: rectangleRect.midX + 15, y: rectangleRect.minY),
            end: CGPoint(x: rectangleRect.midX - 15, y: rectangleRect.maxY),
            options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        context.restoreGState()
    }
}
