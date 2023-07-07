import SwiftUI
import UIKit

final class AboutViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.addSublayer(gradientLayer)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
            .configure {
                $0.axis = .vertical
                $0.alignment = .center
                $0.spacing = 48
            }

        view.addAndConstrainSubview(scrollView) {
            $0.edges.equalToSuperview()
        }

        scrollView.addAndConstrainSubview(contentView) {
            $0.edges.width.equalToSuperview()
        }

        contentView.addAndConstrainSubview(stackView) {
            $0.top.greaterThanOrEqualTo(contentView.snp.top).inset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(80)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        gradientLayer.frame = view.bounds
    }

    // MARK: - Private

    private let scrollView = UIScrollView()
        .configure {
            $0.showsVerticalScrollIndicator = false
        }

    private let contentView = UIView()

    private lazy var gradientLayer = CAGradientLayer()
        .configure {
            $0.frame = view.bounds
            $0.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
            $0.startPoint = CGPoint.zero
            $0.endPoint = CGPoint(x: 0.5, y: 1.5)
        }

    private let titleLabel = UILabel()
        .configure {
            $0.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: .init(legibilityWeight: .bold))
            $0.text = "Master of Flags"
            $0.textColor = .white
        }

    private let infoLabel = UILabel()
        .configure {
            $0.font = UIFont.preferredFont(forTextStyle: .title3)
            $0.text =
                """
                This is Master of Flags, the game where you gather experience points (XP) and level up as you become familiar with the world's flags. There are 196 different flags in this game! Your objective is to learn them all🤓

                You gain 15 XP from a correct answer and lose 10 XP from a wrong answer. The correct answer is indicated by the spinning flag!🌀
                You need 450 points to level up☄️

                Browse the encyclopedia to improve your geographical knowledge📚
                """
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
}

struct AboutViewController_Preview: PreviewProvider {
    static var previews: some View = Preview(for: UINavigationController(rootViewController: AboutViewController()))
}
