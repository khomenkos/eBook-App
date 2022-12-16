//
//  Route.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 15.12.2022.
//

import Foundation

struct Constants {
    static let apiKey = "AIzaSyD_I9-SnC4cFhEz_8GeJ7-d4tQ-lUTnEKs"
    static let baseUrl = "https://www.googleapis.com/books/v1/volumes"
    static let defaultImage = "https://cdn1.iconfinder.com/data/icons/love-for-books/154/pdf-book-512.png"
}

enum Route {
    case getRecommendedBooks
    case getTrendingBooks
    case getTopBooks
    case getSearchView(String, String?, String?)
    case search(String, String, String?, String?)
    case getBookByID(String)
    
    var discription: String {
        switch self {
        case .getRecommendedBooks: return "?q=intitle:keyes&key="
        case .getTrendingBooks: return "?q=inauthor:Whitehead&key="
        case .getTopBooks: return "?q=inauthor:Smith&key="
        case .getSearchView(let type, let sort, let filter):
            return "?q=thenewyorktimes&printType=\(type)&orderBy=\(sort?.lowercased() ?? "relevance")\(filter?.lowercased() ?? "")&key="
        case .search(let query, let type, let sort, let filter): return "?q=\(query)&printType=\(type)&orderBy=\(sort?.lowercased() ?? "relevance")\(filter?.lowercased() ?? "")&key="
        case .getBookByID(let byID): return "/\(byID)"
        }
    }
}
