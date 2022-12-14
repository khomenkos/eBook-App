//
//  SearchResultsController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 29.11.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: Book)
}

class SearchResultsViewController: UIViewController {

    public var books: [Book] = [Book]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?

    public let searchResultsViewController: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(UINib(nibName: PreviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PreviewTableViewCell.identifier)
        
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsViewController)
        
        searchResultsViewController.delegate = self
        searchResultsViewController.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsViewController.frame = view.bounds
    }
    
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviewTableViewCell.identifier, for: indexPath) as? PreviewTableViewCell else { return UITableViewCell() }
        //cell.selectionStyle = .none
        
        cell.setup(book: books[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchResultsViewControllerDidTapItem(books[indexPath.row])
    }
}

