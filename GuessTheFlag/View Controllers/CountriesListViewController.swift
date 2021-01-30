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
    
    // MARK: - Properties
    var imageCancellables = Set<AnyCancellable>()
    var cancellables = Set<AnyCancellable>()
    var countries: [Country] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let api = API()
    
    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let view = UITableView().forAutoLayout()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        loadCountries()
    }
    
    func loadCountries() {
        api.getCountries()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.countries, on: self)
            .store(in: &cancellables)
    }
}

extension CountriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let country = countries[indexPath.row]

        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.capital
        let placeholder = UIImage(systemName: "doc")
        cell.imageView?.sd_setImage(with: country.flag, placeholderImage: placeholder)
//        URLSession.shared.dataTaskPublisher(for: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg")!)
//            .map { UIImage(data: $0.data) }
//            .receive(on: DispatchQueue.main)
//            .replaceError(with: UIImage().withTintColor(.systemFill))
//            .print()
//            .assign(to: \.image, on: cell.imageView!)
//            .store(in: &self.imageCancellables)
        return cell
    }
}

// MARK: - TableView Delegate Methods
extension CountriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = countries[indexPath.row]
        let detailViewController = CountryDetailViewController(flagImage: country.flag)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

import SwiftUI

struct CountriesListViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: CountriesListViewController(), mode: .dark)
}

