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
        label.font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let capitalLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Capital"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let subregionLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Sub-region"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let nativeNameLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Native Name"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let demonymLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Demonym"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let populationLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Population"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let timeZonesLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Timezones:\n"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let currenciesLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Currencies:\n"
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()

    let languagesLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Languages:\n"
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()

    let mapView: MKMapView = {
        let view = MKMapView().forAutoLayout()
        view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        return view
    }()

    lazy var goUpButton: UIButton = {
        let button = UIButton().forAutoLayout()
        button.setImage(UIImage(systemName: "arrow.up.square.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .label
        button.heightAnchor.constraint(equalToConstant: 75).isActive = true
        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
        button.addTarget(self, action: #selector(goUp), for: .touchDown)
        return button
    }()

    // MARK: - Init
    init(country: Country) {
        flagImageView.sd_setImage(with: country.flag, placeholderImage: UIImage())
        nameLabel.text = "\(country.name)"
        capitalLabel.text = "Capital:\n\(country.capital)"
        demonymLabel.text = "Demonym:\n\(country.demonym)"
        subregionLabel.text = "Sub-region:\n\(country.subregion)"
        nativeNameLabel.text = "Native name:\n\(country.nativeName)"
        populationLabel.text = "Population:\n\(country.population)"
        mapView.centerCoordinate = .init(latitude: country.latlng[0], longitude: country.latlng[1])

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
        stackView.alignment = .center
        contentView.addSubview(stackView)
        contentView.addSubview(mapView)
        mapView.addSubview(goUpButton)

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

            stackView.topAnchor.constraint(equalTo: flagImageView.topAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),

            mapView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 4),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            mapView.bottomAnchor.constraint(equalToSystemSpacingBelow: goUpButton.bottomAnchor, multiplier: 8),
            mapView.trailingAnchor.constraint(equalToSystemSpacingAfter: goUpButton.trailingAnchor, multiplier: 1),

        ])
    }

    // MARK: - Selectors
    @objc private func goUp() {
        HapticEngine.rigid.impactOccurred()
        scrollView.scrollToTop()
    }
}
extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
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

