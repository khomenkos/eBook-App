//
//  BookCollectionViewCell.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 28.11.2022.
//

import UIKit
import SDWebImage

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.frame = contentView.bounds
    }
    
    public func setup(with model: String) {
        guard let url = URL(string: model) else { return }
        cellImageView.sd_setImage(with: url, completed: nil)
    }
}
