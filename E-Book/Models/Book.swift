//
//  Book.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 28.11.2022.
//

import Foundation

struct RecommendedBooks: Codable {
    let items: [Book]
}

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
    let pageCount: Int
    let imageLinks: ImageLinks?
    let averageRating: Float?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}
