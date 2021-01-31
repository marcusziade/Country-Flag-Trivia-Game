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

    // MARK: - Properties
    var location: [Double]! = nil

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
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()

    let nameLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemPurple, text: "Country").forAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()

    let capitalLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemIndigo, text: "Capital").forAutoLayout()
        return label
    }()

    let subregionLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemBlue, text: "Sub-region").forAutoLayout()
        return label
    }()

    let nativeNameLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemGreen, text: "Native Name").forAutoLayout()
        return label
    }()

    let demonymLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemTeal, text: "Demonym").forAutoLayout()
        return label
    }()

    let populationLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemYellow, text: "Population").forAutoLayout()
        return label
    }()

    let timeZonesLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemOrange, text: "Timezones:\n").forAutoLayout()
        return label
    }()

    let currenciesLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemRed, text: "Currencies:\n").forAutoLayout()
        return label
    }()

    let languagesLabel: SpecLabel = {
        let label = SpecLabel(textColor: .systemPink, text: "Languages:\n").forAutoLayout()
        return label
    }()

    let mapView: MKMapView = {
        let view = MKMapView().forAutoLayout()
        view.mapType = .hybrid
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

    lazy var goDownButton: UIButton = {
        let button = UIButton().forAutoLayout()
        button.setImage(UIImage(systemName: "mappin.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .systemTeal
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(goDown), for: .touchDown)
        button.addShadow()
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
        super.init(nibName: nil, bundle: nil)
        guard let location = country.latlng else { return }
        self.location = location

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
        stackView.spacing = 0
        stackView.alignment = .center
        contentView.addSubview(stackView)
        contentView.addSubview(mapView)
        mapView.addSubview(goUpButton)
        flagImageView.addSubview(goDownButton)

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
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0),

            mapView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).with(priority: .defaultHigh),

            mapView.bottomAnchor.constraint(equalToSystemSpacingBelow: goUpButton.bottomAnchor, multiplier: 8),
            mapView.trailingAnchor.constraint(equalToSystemSpacingAfter: goUpButton.trailingAnchor, multiplier: 1),
            flagImageView.bottomAnchor.constraint(equalToSystemSpacingBelow: goDownButton.bottomAnchor, multiplier: 1),
            flagImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: goDownButton.trailingAnchor, multiplier: 1.5),

            flagImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            nameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            capitalLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            subregionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            nativeNameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            demonymLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            populationLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            timeZonesLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            currenciesLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            languagesLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }

    // MARK: - Methods
    private func configureMapView() {
        if location.count > 0 {
            mapView.moveCenterByOffSet(offSet: CGPoint(x: 100, y: 100), coordinate: CLLocationCoordinate2D(latitude: location[0], longitude: location[1]))
            mapView.showsTraffic = true
            UIView.animate(withDuration: 2.5) { [self] in
                mapView.moveCenterByOffSet(offSet: CGPoint(x: 0, y: 0), coordinate: CLLocationCoordinate2D(latitude: location[0], longitude: location[1]))
            }

            let country = MKPointAnnotation()
            country.title = "\(nameLabel.text ?? "")"
            country.coordinate = CLLocationCoordinate2D(latitude: location[0], longitude: location[1])
            mapView.addAnnotation(country)
        } else {
            mapView.mapType = .satelliteFlyover
        }
    }

    // MARK: - Selectors
    @objc private func goUp() {
        HapticEngine.rigid.impactOccurred()
        scrollView.scrollToTop()
    }

    @objc private func goDown() {
        HapticEngine.rigid.impactOccurred()
        scrollView.scrollsToBottom(animated: true)
        configureMapView()
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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        configureMapView()
    }
}

import SwiftUI

struct CountryDetailViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: NavigationController(rootViewController: CountryDetailViewController(country: Country.generateMockCountry())), mode: .light)
}

