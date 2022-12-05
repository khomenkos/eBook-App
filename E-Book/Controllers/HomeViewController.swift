//
//  ViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 25.11.2022.
//

import UIKit

enum Sections: Int {
    case recommended = 0
    case trendingBooks = 1
    case topBooks = 2
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Recommended", "Trending Books", "Top Books"]
    
    var books:[Book] = [Book]()
    
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeTable)
        
        homeTable.delegate = self
        homeTable.dataSource = self
        
        // Setting navigation bar
        title = "Home"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier) as? CollectionViewTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        
        switch indexPath.section {
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTabCell(_ cell: CollectionViewTableViewCell, viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailViewController()
            vc.setup(book: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
