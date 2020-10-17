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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
}
