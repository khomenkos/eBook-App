//
//  SearchTableViewCell.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 29.11.2022.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

    static let identifier = "PreviewTableViewCell"

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    func setup(book: Book) {
        myImage.sd_setImage(with: book.volumeInfo?.imageLinks?.thumbnail?.asUrl)
        titleLabel.text = book.volumeInfo?.title
        authorsLabel.text = book.volumeInfo?.authors?.first
        ratingLabel.text = "\(book.volumeInfo?.averageRating ?? 0)/5"
    }
}
