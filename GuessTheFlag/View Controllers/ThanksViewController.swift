//
//  ThanksViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit
import Lottie

class ThanksViewController: UIViewController {

    // MARK: - Lifecycle Methods
    private lazy var animationView: AnimationView = {
        let view = AnimationView(name: "coffee").forAutoLayout()
        view.contentMode = .scaleAspectFit
        view.loopMode = .autoReverse
        view.play()
//        view.backgroundColor = .clear
        return view
    }()

    override func viewDidLoad() {

      super.viewDidLoad()

        view.backgroundColor = .clear
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

    }
}

import SwiftUI

struct ThanksViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: ThanksViewController(), mode: .dark)
}

