//
//  SpecLabel.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit

class SpecLabel: UILabel {

    init(textColor color: UIColor, text title: String) {
        super.init(frame: .zero)
        font = UIFont.preferredFont(forTextStyle: .headline)
        numberOfLines = 0
        textAlignment = .center
        backgroundColor = color
        text = title
        textColor = .white
        padding(8, 8, 0, 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var insets = UIEdgeInsets.zero

    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width + left + right,
            height: self.frame.height + top + bottom
        )

        insets = UIEdgeInsets(
            top: top,
            left: left,
            bottom: bottom,
            right: right
        )
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
    }
}

