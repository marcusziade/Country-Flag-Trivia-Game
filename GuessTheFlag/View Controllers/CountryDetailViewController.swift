//
//  CountryDetailViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit
import SDWebImage

class CountryDetailViewController: UIViewController {

    // MARK: - UI Components
    let flagImageView: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .systemFill
        return view
    }()

    // MARK: - Init
    init(country: Country) {
        flagImageView.sd_setImage(with: country.flag, placeholderImage: UIImage(systemName: "doc"))
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(flagImageView)
        NSLayoutConstraint.activate([
            flagImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            flagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//import SwiftUI
//
//struct CountryDetailViewController_Preview: PreviewProvider {
//    static var previews: some View = createPreview(for: CountryDetailViewController(country: Country.generateMockCountry()), mode: .dark)
//}
//
