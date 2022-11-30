//
//  SearchViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 27.11.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var books: [Book] = [Book]()
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        //table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Books"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchTable)
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        // Setting navigation bar
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.searchController = searchController
        
        fetch()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    
    private func fetch() {
        ApiManager.shared.getTrendingBooks { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
                DispatchQueue.main.async { [weak self] in
                    self?.searchTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let bookCell = books[indexPath.row]
        cell.setup(book: BookViewModel(title: bookCell.volumeInfo?.title ?? "unknown", authors: bookCell.volumeInfo?.authors?.first ?? "unknown", imageLinks: bookCell.volumeInfo?.imageLinks?.thumbnail ?? " ", averageRating: bookCell.volumeInfo?.averageRating ?? 0))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        ApiManager.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    resultController.books = books
                    resultController.searchResultsViewController.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
