//
//  CountryDetailViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit

class CountryDetailViewController: UIViewController {

    // MARK: - UI Components
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView().forAutoLayout()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        return view
    }()

    let contentView: UIView = {
        let view = UIView().forAutoLayout()
        return view
    }()

    let flagImageView: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Country"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()

    let capitalLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Capital"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()

    let subregionLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Sub-region"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()

    let nativeNameLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Native Name"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let demonymLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Demonym"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let populationLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Population"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let timeZonesLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Timezones: "
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let currenciesLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Currencies: "
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let languagesLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Languages: "
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    let geoView: MKMapView = {
        let view = MKMapView().forAutoLayout()
        view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        return view
    }()

    // MARK: - Init
    init(country: Country) {
        flagImageView.sd_setImage(with: country.flag, placeholderImage: UIImage())
        nameLabel.text = "\(country.name)"
        capitalLabel.text = "Capital: \(country.capital)"
        demonymLabel.text = "Demonym: \(country.demonym)"
        subregionLabel.text = "Sub-region: \(country.subregion)"
        nativeNameLabel.text = "Native name: \(country.nativeName)"
        populationLabel.text = "Population: \(country.population)"
        geoView.centerCoordinate = .init(latitude: country.latlng[0], longitude: country.latlng[1])

        super.init(nibName: nil, bundle: nil)

        country.timezones.forEach { timeZonesLabel.text?.append("\($0) ") }
        country.currencies.forEach { currenciesLabel.text?.append("| \($0.symbol ?? "") \($0.code ?? "") - \($0.name ?? "") |  ") }
        country.languages.forEach { languagesLabel.text?.append("| \($0.name) |  ")}

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(flagImageView)

        let stackView = UIStackView(arrangedSubviews: [flagImageView, nameLabel, capitalLabel, subregionLabel, nativeNameLabel, demonymLabel, populationLabel, timeZonesLabel, currenciesLabel, languagesLabel]).forAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .leading
        contentView.addSubview(stackView)
        contentView.addSubview(geoView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            geoView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 4),
            geoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            geoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            geoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

// MARK: - UIScrollView Delegate Methods
extension CountryDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }

        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
}

import SwiftUI

struct CountryDetailViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: NavigationController(rootViewController: CountryDetailViewController(country: Country.generateMockCountry())), mode: .light)
}

