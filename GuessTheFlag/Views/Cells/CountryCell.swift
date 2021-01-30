//
//  CountryCell.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit
import Combine
import SDWebImage

class CountryCell: UICollectionViewCell, Reusable {

    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()

    // MARK: - UI Components
    let flagImageView: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "Finland")!
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Country"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    let capitalLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.text = "Capital"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        label.numberOfLines = 0
        return label
    }()

    let bottomShadow: UIView = {
        let gradientView = BottomShadowGradient()
        let view = UIView().forAutoLayout()
        view.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        return view
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        contentView.addSubview(flagImageView)
        flagImageView.addSubview(bottomShadow)
        let stackView = UIStackView(arrangedSubviews: [nameLabel, capitalLabel]).forAutoLayout().forAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            bottomShadow.topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomShadow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomShadow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomShadow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with country: Country) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
//        URLSession.shared.dataTaskPublisher(for: country.flag)
//            .map { UIImage(data: $0.data) }
//            .replaceError(with: UIImage().withTintColor(.systemFill))
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.image, on: flagImageView)
//            .store(in: &cancellables)

        flagImageView.sd_setImage(with: country.flag, placeholderImage: UIImage().withTintColor(.systemFill))
    }
}

import SwiftUI

struct CountryCell_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: CountryCell(), mode: .dark, width: 200, height: 200)
}

