import Foundation
import SnapKit
import UIKit

final class SettingsViewController: ViewController {

    init(model: SettingsViewModel) {
        self.model = model
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("Settings", comment: "Settings nav title")

        view.addAndConstrainSubview(collectionView) {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Private

    private let model: SettingsViewModel

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        .configure {
            $0.dataSource = self
            $0.delegate = self

            $0.registerCell(SettingsRegularCell.self)
            $0.registerCell(SettingsHardModeCell.self)
            $0.registerSupplementaryView(SettingsHeaderView.self, kind: .sectionHeader)
        }

    private var viewLayout: UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionLayout: NSCollectionLayoutSection

            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.showsSeparators = false
            sectionLayout = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)

            let header = NSCollectionLayoutBoundarySupplementaryItem.create(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(40)
                ),
                elementKind: .sectionHeader,
                alignment: .topLeading
            )

            sectionLayout.boundarySupplementaryItems = [header]

            return sectionLayout
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SettingsSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .general:
            return model.items.general.count
        case .game:
            return model.items.game.count
        case .support:
            return model.items.support.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .general:
            return collectionView.dequeueCell(SettingsRegularCell.self, forIndexPath: indexPath)
                .configure {
                    $0.configure(with: model.items.general[indexPath.item])
                }
        case .game:
            return collectionView.dequeueCell(SettingsHardModeCell.self, forIndexPath: indexPath)
                .configure {
                    $0.configure(with: model.items.game[indexPath.item], isEnabled: model.settings.isHardModeEnabled)
                    $0.onHardModeToggled = { [unowned self] in
                        model.settings.isHardModeEnabled = $0
                    }
                }
        case .support:
            return collectionView.dequeueCell(SettingsRegularCell.self, forIndexPath: indexPath)
                .configure {
                    $0.configure(with: model.items.support[indexPath.item])
                }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SettingsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        switch section {
        case .general:
            if let viewController = model.items.general[indexPath.item].viewController {
                viewController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(viewController, animated: true)
            }

        case .game:
            break

        case .support:
            let supportItem = model.items.support[indexPath.item]
            switch supportItem.id {
            case .feedback:
                UIApplication.shared.open(supportItem.url!)
            case .rate:
                AppStoreReviewManager.requestReview()
            case .share:
                let title = NSLocalizedString("Share Master of Flags", comment: "Share title label")
                let appStoreURL = URL(string: "https://apps.apple.com/app/master-of-flags/id1484270248")!
                let shareViewController = UIActivityViewController(
                    activityItems: [title, appStoreURL], applicationActivities: nil)
                shareViewController.popoverPresentationController?.sourceView = view
                present(shareViewController, animated: true)
            default:
                if let viewController = supportItem.viewController {
                    viewController.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UICollectionReusableView() }
        return
            collectionView.dequeueSupplementaryView(
                SettingsHeaderView.self,
                kind: .sectionHeader,
                indexPath: indexPath
            )
            .configure {
                $0.title = section.headerTitle
            }
    }
}
