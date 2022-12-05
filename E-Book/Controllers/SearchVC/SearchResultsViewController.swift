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
        table.register(UINib(nibName: PreviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PreviewTableViewCell.identifier)
        
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviewTableViewCell.identifier, for: indexPath) as? PreviewTableViewCell else { return UITableViewCell() }
        //cell.selectionStyle = .none
        let bookCell = books[indexPath.row]
        cell.setup(book: BookViewModel(id: bookCell.id, title: bookCell.volumeInfo?.title ?? "Title unknown",
                                       authors: bookCell.volumeInfo?.authors?.first ?? "Author unknown",
                                       imageLinks: bookCell.volumeInfo?.imageLinks?.thumbnail ?? Constants.defaultImage,
                                       averageRating: bookCell.volumeInfo?.averageRating ?? 0))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bookCell = self.books[indexPath.row]
        delegate?.searchResultsViewControllerDidTapItem(DetailViewModel(
            id: bookCell.id,
            title: bookCell.volumeInfo?.title ?? "Title unknown",
            authors: bookCell.volumeInfo?.authors?.first ?? "Author unknown",
            description: bookCell.volumeInfo?.description ?? "",
            imageLinks: bookCell.volumeInfo?.imageLinks?.thumbnail ?? Constants.defaultImage,
            averageRating: bookCell.volumeInfo?.averageRating ?? 0,
            language: bookCell.volumeInfo?.language ?? "ENG",
            pageCount: bookCell.volumeInfo?.pageCount ?? 0,
            book: bookCell))
    }
}

