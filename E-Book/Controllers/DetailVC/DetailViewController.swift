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
    var book: Book!
    private var isFavorite = true
    private var downloadLink: String?
    private var saleability: String = ""

    //MARK: Outlets
    
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
    
    // Info View
    private var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(named: "blue")
        return view
    }()
        
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
    
    // Stack Info View
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
    
    // Stack Buttons
    private let stackButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var readWEBButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read WEB Page", for: .normal)
        button.addTarget(self, action: #selector(openWebBook), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "orange")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans Light", size: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private lazy var readPDFButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read PDF", for: .normal)
        button.addTarget(self, action: #selector(openPdfBook), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "orange")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans Light", size: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy Book!", for: .normal)
        button.addTarget(self, action: #selector(openWebBook), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "red")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans Light", size: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    // Favorite button
    private lazy var favButton: UIButton = {
        isFavorite = UserDefaultsManager.shared.isFavoriteMovie(book)
        let imageName = isFavorite ? "heart.fill" : "heart"
        let button = UIButton()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeSymbol(name: imageName, size: 30, weight: .light, scale: .medium)
        button.tintColor = UIColor(named: "yellow")
        button.addTarget(self, action: #selector(favoriteClicked), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "blue")?.cgColor
        return button
    }()
    
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeSymbol(name: "info.circle", size: 25, weight: .light, scale: .medium)
        button.addTarget(self, action: #selector(alert), for: .touchUpInside)
        button.tintColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        setupScrollView()
        setupViews()
        setNavBar()
    }
    
    // MARK: Buttons Action
    @objc func alert() {
        switch saleability {
        case Saleability.forSale.rawValue:
            settingAlert(title: "Sale", message: "You need to buy a book to start reading it.")
        case Saleability.notForSale.rawValue:
            settingAlert(title: "Not for sale", message: "This book is free. But you can only read the description of the book.")
        case Saleability.free.rawValue:
            settingAlert(title: "Free", message: "This book is free. Сlick on the READ button and enjoy reading.")
        default:
            return
        }
    }
    
    @objc func favoriteClicked() {
        if isFavorite {
            UserDefaultsManager.shared.removeMovieFromFavorites(book)
            favButton.sizeSymbol(name: "heart", size: 30, weight: .light, scale: .medium)
            favButton.tintColor = UIColor(named: "yellow")
            favButton.layer.borderColor = UIColor(named: "blue")?.cgColor
            isFavorite = !isFavorite
        } else {
            UserDefaultsManager.shared.addMovieToFavorites(book)
            favButton.sizeSymbol(name: "heart.fill", size: 30, weight: .light, scale: .medium)
            favButton.tintColor = UIColor(named: "blue")
            favButton.layer.borderColor = UIColor(named: "yellow")?.cgColor
            isFavorite = !isFavorite
        }
    }

    @objc func openPdfBook() {
        //guard let url = "".asUrl else { return }
        guard let url = Bundle.main.url(forResource: "swift", withExtension: "pdf") else { return }
        let pdfViewController = PdfViewController(pdfUrl: url)
        present(pdfViewController, animated: true, completion: nil)
    }
    
    @objc func openWebBook() {
        switch saleability {
        case Saleability.forSale.rawValue:
            setPresentWeb(book.saleInfo?.buyLink?.asUrl)
        case Saleability.notForSale.rawValue:
            setPresentWeb(book.volumeInfo?.previewLink?.asUrl)
        case Saleability.free.rawValue:
            setPresentWeb(book.accessInfo?.webReaderLink?.asUrl)
        default:
            return
        }
    }
    
    // MARK: Settings 
    
    private func setPresentWeb(_ url: URL?) {
        guard let url = url else { return }
        let vc = WebViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    // Navigation Bar
    func setNavBar() {
        saleability = book.saleInfo?.saleability ?? ""
        downloadLink = book.accessInfo?.pdf?.downloadLink
        
        switch saleability {
        case Saleability.forSale.rawValue:
            infoButton.tintColor = UIColor(named: "red")
            readWEBButton.isHidden = true
            readPDFButton.isHidden = true
        case Saleability.notForSale.rawValue:
            infoButton.tintColor = UIColor(named: "yellow")
            buyButton.isHidden = true
            if downloadLink == nil {
                readPDFButton.isHidden = true
            }
        case Saleability.free.rawValue:
            infoButton.tintColor = UIColor(named: "green")
            buyButton.isHidden = true
            if downloadLink == nil {
                readPDFButton.isHidden = true
            }
        default:
            return
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    func settingAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
        
    func setup() {
        cellsImageView.sd_setImage(with: book.volumeInfo?.imageLinks?.thumbnail?.asUrl)
        titleLabel.text = book.volumeInfo?.title
        authorLabel.text = book.volumeInfo?.authors?.first
        ratingNumberLabel.text = "\(book.volumeInfo?.averageRating ?? 0)/5"
        numberOfPagesLabel.text = "\(book.volumeInfo?.pageCount ?? 0) pages"
        languageTitleLabel.text = book.volumeInfo?.language?.uppercased()
        descriptionLabel.text = book.volumeInfo?.description
    }
    
    //MARK: Constraints
    func setupScrollView() {
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
            cellsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellsImageView.widthAnchor.constraint(equalToConstant: 155),
            cellsImageView.heightAnchor.constraint(equalToConstant: 220)
        ])

        contentView.addSubview(favButton)
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 170),
            favButton.trailingAnchor.constraint(equalTo: cellsImageView.trailingAnchor, constant: 70),
            favButton.widthAnchor.constraint(equalToConstant: 50),
            favButton.heightAnchor.constraint(equalToConstant: 50)
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
        
        contentView.addSubview(stackButtons)
        stackButtons.addArrangedSubview(readPDFButton)
        stackButtons.addArrangedSubview(readWEBButton)
        stackButtons.addArrangedSubview(buyButton)

        NSLayoutConstraint.activate([
            readWEBButton.widthAnchor.constraint(equalToConstant: 140),
            readWEBButton.heightAnchor.constraint(equalToConstant: 45),
            buyButton.widthAnchor.constraint(equalToConstant: 140),
            buyButton.heightAnchor.constraint(equalToConstant: 45),
            stackButtons.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 10),
            stackButtons.centerXAnchor.constraint(equalTo: infoView.centerXAnchor)
        ])
            
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: stackButtons.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
