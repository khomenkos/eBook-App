//
//  DetailViewModel.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 30.11.2022.
//

import Foundation

struct DetailViewModel {
    let id: String
    let title: String
    let authors: String
    let description: String
    let imageLinks: String
    let averageRating: Float
    let language: String
    let pageCount: Int
    let book: Book
}
