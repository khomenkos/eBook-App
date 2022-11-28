//
//  ViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 25.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Category", "Recommended", "Trending Books", "Top Books"]
    
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.register(CategoryViewCellTableViewCell.self, forCellReuseIdentifier: CategoryViewCellTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeTable)
        
        homeTable.delegate = self
        homeTable.dataSource = self
        
        // Setting navigation bar
        title = "Books"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cellCategory = tableView.dequeueReusableCell(withIdentifier: CategoryViewCellTableViewCell.identifier, for: indexPath) as? CategoryViewCellTableViewCell ?? UITableViewCell()
            return cellCategory
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell ?? UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 16,
                                             weight: .medium)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

