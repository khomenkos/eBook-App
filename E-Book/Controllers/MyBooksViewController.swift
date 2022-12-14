//
//  MyBooksViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 27.11.2022.
//

import UIKit

class MyBooksViewController: UIViewController {
    
    private var books: [Book] = [Book]()
    var booksaaa:[Book] = [Book]()
    
    private let favoriteTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(UINib(nibName: PreviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PreviewTableViewCell.identifier)
        return table
    }()
    
    // No Favorite Books Image
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(named: "yellow")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Favorite books will appear here!"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(favoriteTable)
        
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
        title = "My Books"
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteTable.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNoFavorites()
        self.books = UserDefaultsManager.shared.fetchFavoriteMovies()
        favoriteTable.reloadData()
    }
    
    func setupViews(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(starImage)
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            starImage.widthAnchor.constraint(equalToConstant: 25),
            starImage.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func showNoFavorites() {
        stackView.isHidden = UserDefaultsManager().favorites?.count ?? 0 > 0
    }
}

extension MyBooksViewController: UITableViewDelegate, UITableViewDataSource {
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
