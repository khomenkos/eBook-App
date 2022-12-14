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
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(UINib(nibName: PreviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PreviewTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Title, Author"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchTable)
        
        searchTable.delegate = self
        searchTable.dataSource = self
        searchController.searchResultsUpdater = self
        fetchData()
        
        // Setting navigation bar
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }

    private func fetchData() {
        ApiManager.shared.getSearchView { [weak self] result in
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviewTableViewCell.identifier, for: indexPath) as? PreviewTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setup(book: books[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = DetailViewController()
        vc.book = books[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidTapItem(_ viewModel: Book) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailViewController()
            vc.book = viewModel
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        resultController.delegate = self
        
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
