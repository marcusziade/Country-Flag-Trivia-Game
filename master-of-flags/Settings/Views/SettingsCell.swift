import Foundation
import UIKit
import SwiftUI

class SettingsCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let stackView = UIStackView(arrangedSubviews: [itemBadgeView, titleLabel])
            .configure {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.spacing = 12
                $0.alignment = .center
            }

        contentView.addSubviews(blurView, stackView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 0.5),
            blurView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.5),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: blurView.trailingAnchor, multiplier: 1.5),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: blurView.bottomAnchor, multiplier: 0.5),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 0.5),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: blurView.leadingAnchor, multiplier: 1.5),
            blurView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1.5),
            blurView.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0.5),
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let itemBadgeView = SettingsItemBadgeView()

    let titleLabel = UILabel()
        .configure {
            #if DEBUG
                $0.text = "Item title"
            #endif
        }

    // MARK: - Private

    private let blurView = UIVisualEffectView()
        .configure {
            let effect = UIBlurEffect(style: .systemChromeMaterial)
            $0.effect = effect
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

    private lazy var containerView = UIView()
        .configure {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 12
        }
}

struct SettingsCell_Preview: PreviewProvider {
    static var previews: some View = Preview(for: SettingsCell())
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}
