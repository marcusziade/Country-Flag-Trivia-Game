//
//  UIScrollViewExtensions.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }

    func scrollsToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: contentOffset.x,
                                   y: contentSize.height - bounds.height + adjustedContentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
}
