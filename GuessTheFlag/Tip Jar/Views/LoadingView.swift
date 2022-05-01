//
//  LoadingView.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 1.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class LoadingView: UIView {
    
    var state: LoadingState {
        didSet {
            titleLabel.text = state.title
            titleLabelContainerView.backgroundColor = state.color
        }
    }
    
    init(state: LoadingState) {
        self.state = state
        super.init(frame: .zero)
        
        addAndConstrainSubview(blurView) {
            $0.edges.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabelContainerView, loaderView]).configure {
            $0.axis = .vertical
            $0.spacing = 32
            $0.alignment = .center
        }
        
        addAndConstrainSubview(stackView) {
            $0.top.equalToSuperview().inset(120)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        loaderView.startAnimating()
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1
        }
    }
    
    func stop() {
        loaderView.stopAnimating()
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 0
        }
    }
    
    // MARK: - Private
    
    private let blurView = UIVisualEffectView().configure {
        let effect = UIBlurEffect(style: .systemChromeMaterial)
        $0.effect = effect
    }
    
    private lazy var titleLabelContainerView = UIView().configure {
        $0.layer.cornerRadius = 6
        $0.backgroundColor = .systemFill
        $0.addAndConstrainSubview(titleLabel) {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }

    private let titleLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        $0.textColor = .white
#if DEBUG
        $0.text = "Loading"
#endif
    }
    
    private let loaderView = UIActivityIndicatorView(style: .large).configure {
        $0.startAnimating()
    }
}

#if DEBUG

import SwiftUI

struct LoadingView_Preview: PreviewProvider {
    static var previews: some View = Preview(for: LoadingView(state: .loading))
        .preferredColorScheme(.dark)
}

#endif
