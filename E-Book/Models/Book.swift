//
//  Book.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 28.11.2022.
//

import Foundation

struct RecommendedBooks: Codable {
//    let status: Int
//    let message: String
//    let data: T?
//    let error: String?
    let items: [Book]
}

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
    let pageCount: Int?
    let imageLinks: ImageLinks?
    let averageRating: Float?
    let language: String?
    let previewLink: String?
}

struct SaleInfo: Codable {
    let saleability: String?
    let isEbook: Bool?
    let listPrice: ListPrice?
    let buyLink: String?
}

struct AccessInfo: Codable {
    let pdf: Pdf?
    let webReaderLink: String?
}

struct ListPrice: Codable {
    let amount: Float?
}

struct Pdf: Codable {
    let downloadLink: String?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}

enum Saleability: String {
    case free = "FREE"
    case notForSale = "NOT_FOR_SALE"
    case forSale = "FOR_SALE"
}
