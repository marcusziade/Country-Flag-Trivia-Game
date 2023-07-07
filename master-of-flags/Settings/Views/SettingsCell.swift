import Foundation
import SnapKit
import UIKit

class SettingsCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addAndConstrainSubview(blurView) {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(4)
        }

        let stackView = UIStackView(arrangedSubviews: [itemBadgeView, titleLabel])
            .configure {
                $0.spacing = 12
                $0.alignment = .center
            }

        contentView.addAndConstrainSubview(stackView) {
            $0.horizontalEdges.equalTo(blurView.snp.horizontalEdges).inset(12)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
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
        }

    private lazy var containerView = UIView()
        .configure {
            $0.layer.cornerRadius = 12
        }
}
