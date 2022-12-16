//
//  SearchViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 27.11.2022.
//

import UIKit
import ProgressHUD

enum Filter: String {
    case byPartial = "Partial"
    case byFull = "Full"
    case byFreeEbooks = "Free-ebooks"
    case byPaidEbooks = "Paid-ebooks"
    case byEbooks = "Ebooks"
}

enum Sort: String {
    case byRelevance = "Relevance"
    case byNewest = "Newest"
}

class SearchViewController: UIViewController {
    
    private var books: [Book] = [Book]()
    private let items = ["Books", "Magazines"]
    private var filter: String? = nil
    private var sort: String? = nil
    private var type = 0
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(UINib(nibName: PreviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PreviewTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Title, Author"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame.size.height = 40.0
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.yellow
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchTable)
        searchTable.delegate = self
        searchTable.dataSource = self
        
        // Hide keyboard while scrolling
        searchTable.keyboardDismissMode = .onDrag
        
        searchController.searchResultsUpdater = self
        searchTable.tableHeaderView = segmentedControl
        
        fetchData(type: items[type], orderBy: sort, filter: filter)
        
        // Setting navigation bar
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
                                                              style: .done,
                                                              target: self,
                                                              action: #selector(filterAction)),
                                              UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"),
                                                              style: .done,
                                                              target: self,
                                                              action: #selector(sortAction))]
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        type = segmentedControl.selectedSegmentIndex
        fetchData(type: items[type], orderBy: sort, filter: filter)
    }
    
    @objc func sortAction() {
        let alert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Sort.byRelevance.rawValue, style: .default, handler: alertSortAction))
        alert.addAction(UIAlertAction(title: Sort.byNewest.rawValue, style: .default, handler: alertSortAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func filterAction() {
        let alert = UIAlertController(title: "Filter by", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Filter.byPartial.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byFull.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byFreeEbooks.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byPaidEbooks.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byEbooks.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: "Delete filters", style: .destructive, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func alertSortAction(_ action: UIAlertAction) {
        sort = action.title
        fetchData(type: items[type], orderBy: sort, filter: filter)
    }
    
    func alertFilterAction(_ action: UIAlertAction) {
        if action.style == .destructive{
            filter = nil
            fetchData(type: items[type], orderBy: sort, filter: filter)
        } else {
            filter = action.title
        }
        guard let filterAction = filter else { return }
        fetchData(type: items[type], orderBy: sort, filter: "&filter=\(filterAction)")
        filter = "&filter=\(action.title ?? "paid-ebooks")"
    }
    
    private func fetchData(type: String, orderBy: String?, filter: String?) {
        ProgressHUD.show()
        ApiManager.shared.getSearchView(type: type, orderBy: orderBy, filter: filter) { [weak self] result in
            switch result {
            case .success(let books):
                ProgressHUD.dismiss()
                self?.books = books
                DispatchQueue.main.async { [weak self] in
                    self?.searchTable.reloadData()
                }
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
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
              //query.trimmingCharacters(in: .whitespaces).count >= 3,
              
                let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        ProgressHUD.show()
        resultController.delegate = self
        
        ApiManager.shared.search(with: query, type: items[type], orderBy: sort, filter: filter) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    ProgressHUD.dismiss()
                    resultController.books = books
                    resultController.searchResultsTable.reloadData()
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
    }
}
