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
    enum Section: CaseIterable {
        case countries
    }
    
    // MARK: - Properties
    var imageCancellables = Set<AnyCancellable>()
    var cancellables = Set<AnyCancellable>()
    var countries: [Country] = [] {
        didSet {
            reload()
        }
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Country>! = nil
    let api = API()
    
    // MARK: - UI Components
    lazy private var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).forAutoLayout()
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()

    lazy var regionPicker: UISegmentedControl = {
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
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = regionPicker
        navigationItem.backButtonDisplayMode = .minimal
        view.backgroundColor = .systemBackground

        view.layer.addSublayer(gradientLayer)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        loadCountries()
    }
    
    // MARK: - Methods
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(0.4)
                ),
                subitem: item,
                count: 2
            )

            let section = NSCollectionLayoutSection(group: containerGroup)
            return section
        }
        return layout
    }

    func configureDataSource() {
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

    func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Country>()
        snapshot.appendSections([.countries])
        snapshot.appendItems(countries)
        dataSource.apply(snapshot)
    }

    func loadCountries(for region: Region = .europe) {
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
    @objc func regionChanged() {
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

