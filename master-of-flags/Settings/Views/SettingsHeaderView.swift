import Foundation
import UIKit

final class SettingsHeaderView: UICollectionReusableView {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addAndConstrainSubview(titleLabel) {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private let titleLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: .init(legibilityWeight: .bold))
    }
}


