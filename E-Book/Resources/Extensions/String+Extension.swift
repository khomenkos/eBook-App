//
//  String+Extension.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 29.11.2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}

