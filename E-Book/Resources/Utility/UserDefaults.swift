//
//  Utility.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 01.12.2022.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    private init() {}
    
    private enum DefaultKeys: String {
        case favorite
    }
    
    private var favorites: [Book]? {
        get {
            if let data = defaults.object(forKey: DefaultKeys.favorite.rawValue) as? Data,
               let books = try? PropertyListDecoder().decode(Array<Book>.self, from: data) {
                return books
            }
            return []
        } set {
            guard let value = newValue else {return}
            defaults.set(try? PropertyListEncoder().encode(value), forKey: DefaultKeys.favorite.rawValue)
        }
    }
    
    func addMovieToFavorites(_ book: Book) {
        guard var array = favorites else {return}
        
        array.append(book)
        favorites = array
    }
    
    func isFavoriteMovie(_ book: Book) -> Bool {
        guard let favoritesArray = favorites else { return false }
        for favorite in favoritesArray {
            if favorite.id == book.id {
                return true
            }
        }
        return false
    }
    
    func removeMovieFromFavorites(_ book: Book) {
        guard var favoriteArray = favorites else {return}
        var index = Int()
        for (i,favorite) in favoriteArray.enumerated() {
            if favorite.id == book.id {
                index = i
            }
        }
        favoriteArray.remove(at: index)
        favorites = favoriteArray
    }
    
    func fetchFavoriteMovies() -> [Book] {
        guard let favorites = favorites else {return []}
        return favorites
    }
}

