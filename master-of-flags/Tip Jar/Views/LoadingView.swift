import Foundation
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

        let stackView = UIStackView(arrangedSubviews: [titleLabelContainerView, loaderView])
            .configure {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.axis = .vertical
                $0.spacing = 32
                $0.alignment = .center
            }
        
        addSubviews(blurView, stackView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
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

    private let blurView = UIVisualEffectView()
        .configure {
            let effect = UIBlurEffect(style: .systemChromeMaterial)
            $0.effect = effect
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

    private lazy var titleLabelContainerView = UIView()
        .configure {
            $0.layer.cornerRadius = 6
            $0.backgroundColor = .systemFill
            $0.addAndConstrainSubview(titleLabel) {
                $0.verticalEdges.equalToSuperview().inset(8)
                $0.horizontalEdges.equalToSuperview().inset(16)
            }
        }

    private let titleLabel = UILabel()
        .configure {
            $0.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
            $0.textColor = .white
            #if DEBUG
                $0.text = "Loading"
            #endif
        }

    private let loaderView = UIActivityIndicatorView(style: .large)
        .configure {
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
