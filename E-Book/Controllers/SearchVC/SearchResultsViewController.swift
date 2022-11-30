//
//  SearchResultsController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 29.11.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: DetailViewModel)
}

class SearchResultsViewController: UIViewController {

    public var books: [Book] = [Book]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?

    public let searchResultsViewController: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        //table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        //cell.selectionStyle = .none
        let bookCell = books[indexPath.row]
        cell.setup(book: BookViewModel(title: bookCell.volumeInfo?.title ?? "unknown", authors: bookCell.volumeInfo?.authors?.first ?? "unknown", imageLinks: bookCell.volumeInfo?.imageLinks?.thumbnail ?? " ", averageRating: bookCell.volumeInfo?.averageRating ?? 0))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bookCell = self.books[indexPath.row]
        delegate?.searchResultsViewControllerDidTapItem(DetailViewModel(title: bookCell.volumeInfo?.title ?? "unknown", authors: bookCell.volumeInfo?.authors?.first ?? "unknown", description: bookCell.volumeInfo?.description ?? "unknown", imageLinks: bookCell.volumeInfo?.imageLinks?.thumbnail ?? " ", averageRating: bookCell.volumeInfo?.averageRating ?? 0))
    }
}
