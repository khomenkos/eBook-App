//
//  ViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 25.11.2022.
//

import UIKit

enum Sections: Int {
    case category = 0
    case recommended = 1
    case trendingBooks = 2
    case topBooks = 3
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Category", "Recommended", "Trending Books", "Top Books"]
    
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier) as? CollectionViewTableViewCell,
              let cellCategory = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else { return UITableViewCell() }
        switch indexPath.section {
        case Sections.category.rawValue:
            return cellCategory
        case Sections.recommended.rawValue:
            ApiManager.shared.getRecommendedBooks { results in
                switch results {
                case .success(let books):
                    cell.configure(with: books)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.trendingBooks.rawValue:
            ApiManager.shared.getTrendingBooks { results in
                switch results {
                case .success(let books):
                    cell.configure(with: books)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.topBooks.rawValue:
            ApiManager.shared.getTopBooks { results in
                switch results {
                case .success(let books):
                    cell.configure(with: books)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 16,
                                             weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .darkGray
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

