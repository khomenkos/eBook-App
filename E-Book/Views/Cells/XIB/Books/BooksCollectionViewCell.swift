//
//  BooksCollectionViewCell.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 29.11.2022.
//

import UIKit
import SDWebImage

class BooksCollectionViewCell: UICollectionViewCell {

    static let identifier = "BooksCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    
    func setup(book: Book) {
        imageView.sd_setImage(with: book.volumeInfo?.imageLinks?.thumbnail?.asUrl ?? Constants.defaultImage.asUrl) 
        imageView.cornerRadius = 10
        titleLabel.text = book.volumeInfo?.title
        authorsLabel.text = book.volumeInfo?.authors?.first
    }
}
