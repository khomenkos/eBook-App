//
//  DetailViewController.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 30.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private let cellsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    //Info View
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Rating"
        return label
    }()
    private let pagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Number of pages"
        return label
    }()
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans Light", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Language"
        return label
    }()
    
    private let ratingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let numberOfPagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let languageTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Gill Sans SemiBold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Stack View
    
    private let stackRatingView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        

        return stackView
    }()
    
    private let stackPagesView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        

        return stackView
    }()
    
    private let stackLangView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        

        return stackView
    }()
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupViews()
    }
    
    func setup(book: DetailViewModel) {
        cellsImageView.sd_setImage(with: book.imageLinks.asUrl)
        titleLabel.text = book.title
        authorLabel.text = book.authors
        ratingNumberLabel.text = "\(book.averageRating)/5"
        numberOfPagesLabel.text = "\(book.pageCount) pages"
        languageTitleLabel.text = book.language
        descriptionLabel.text = book.description
    }
        
    // Settings and Constraints
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        
        contentView.addSubview(cellsImageView)
        NSLayoutConstraint.activate([
            cellsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -50),
            cellsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellsImageView.widthAnchor.constraint(equalToConstant: 155),
            cellsImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cellsImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        contentView.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        contentView.addSubview(infoView)
        NSLayoutConstraint.activate([
            infoView.widthAnchor.constraint(equalToConstant: 340),
            infoView.heightAnchor.constraint(equalToConstant: 80),
            infoView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            infoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        infoView.addSubview(stackRatingView)
        stackRatingView.addArrangedSubview(ratingLabel)
        stackRatingView.addArrangedSubview(ratingNumberLabel)
        NSLayoutConstraint.activate([
            stackRatingView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            stackRatingView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])
        
        infoView.addSubview(stackPagesView)
        stackPagesView.addArrangedSubview(pagesLabel)
        stackPagesView.addArrangedSubview(numberOfPagesLabel)
        NSLayoutConstraint.activate([
            stackPagesView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            stackPagesView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])

        infoView.addSubview(stackLangView)
        stackLangView.addArrangedSubview(languageLabel)
        stackLangView.addArrangedSubview(languageTitleLabel)
        NSLayoutConstraint.activate([
            stackLangView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            stackLangView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])

        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
