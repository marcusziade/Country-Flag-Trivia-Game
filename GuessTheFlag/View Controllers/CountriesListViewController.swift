//
//  CountriesListViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import UIKit
import Combine

class CountriesListViewController: UIViewController {

    // MARK: - Types
    private enum Section: CaseIterable {
        case countries
    }
    
    // MARK: - Properties
    private var imageCancellables = Set<AnyCancellable>()
    private var cancellables = Set<AnyCancellable>()
    private var countries: [Country] = [] {
        didSet {
            reload()
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, Country>! = nil
    private let api = API()
    
    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).forAutoLayout()
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()

    private lazy var regionPicker: UISegmentedControl = {
        let picker = UISegmentedControl(type: Region.self)
        picker.selectedSegmentIndex = 0
        picker.addTarget(self, action: #selector(regionChanged), for: .valueChanged)
        return picker
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.orange.cgColor, UIColor.white.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.red.cgColor]
        gradient.startPoint = CGPoint(x: 0.3, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.9, y: 0.8)
        gradient.opacity = 0.4
        return gradient
    }()

    private let loadingSpinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView().forAutoLayout()
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alpha = 0
        navigationItem.titleView = regionPicker
        navigationItem.backButtonDisplayMode = .minimal
        view.backgroundColor = .systemBackground

        view.layer.addSublayer(gradientLayer)
        view.addSubview(collectionView)
        view.addSubview(loadingSpinner)
        NSLayoutConstraint.activate([
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        loadCountries()
    }
    
    // MARK: - Methods
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, environment in
            let columns = self?.columnsFor(traitCollection: environment.traitCollection)
            let itemDimen: CGFloat = 1.0 / columns!
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemDimen),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(itemDimen)
                ), subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: containerGroup)
            return section
        }
        return layout
    }

    private func columnsFor(traitCollection: UITraitCollection) -> CGFloat {
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
            case (.compact, .regular): //iPhone Portrait
                return 2
            case (.compact, .compact):
                return 2
            case (.regular, .regular): //iPad
                return 5
            default:
                return 2
        }
    }

    private func configureDataSource() {
        dataSource = nil
        let cellRegistration = UICollectionView.CellRegistration<CountryCell, Country> { cell, indexPath, country in
            cell.configure(with: country)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Country>(collectionView: collectionView,
                                                                          cellProvider: { collectionView, indexPath, country -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: country)
        })

        reload()
    }

    private func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Country>()
        snapshot.appendSections([.countries])
        snapshot.appendItems(countries)
        dataSource.apply(snapshot)

        loadingSpinner.stopAnimating()
        collectionView.fadeIn(duration: 0.25)
    }

    private func loadCountries(for region: Region = .europe) {
        let failing = Set<URL>([
            URL(string: "https://restcountries.eu/data/ecu.svg")!,
            URL(string: "https://restcountries.eu/data/nic.svg")!,
        ])

        api.getCountries(for: region)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .flatMap {
                Publishers.Sequence(sequence: $0)
            }
            .filter {
                !failing.contains($0.flag)
            }
            .collect()
            .assign(to: \.countries, on: self)
            .store(in: &cancellables)

        configureDataSource()
    }

    // MARK: - Selectors
    @objc private func regionChanged() {
        HapticEngine.select.selectionChanged()
        switch regionPicker.selectedSegmentIndex {
            case 0:
                loadCountries(for: .europe)
            case 1:
                loadCountries(for: .asia)
            case 2:
                loadCountries(for: .africa)
            case 3:
                loadCountries(for: .oceania)
            default:
                loadCountries(for: .americas)
        }
    }
}

// MARK: - CollectionView Delegate Methods
extension CountriesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let country = countries[indexPath.row]
        let detailViewController = CountryDetailViewController(country: country)
        detailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

import SwiftUI

struct CountriesListViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: NavigationController(rootViewController: CountriesListViewController()), mode: .dark)
}

