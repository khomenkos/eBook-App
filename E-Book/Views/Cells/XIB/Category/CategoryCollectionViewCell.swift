//
//  CategoryCollectionViewCell.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 29.11.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "CategoryCollectionViewCell"
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    func setup(book: String) {
        categoryTitle.text = book
    }

}
