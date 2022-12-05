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
    
    
    func setup(book: BookViewModel) {
        myImage.sd_setImage(with: book.imageLinks.asUrl)
        titleLabel.text = book.title
        authorsLabel.text = book.authors
        ratingLabel.text = "\(book.averageRating)/5"
    }
    
}
