//
//  ApiManager.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 28.11.2022.
//

import Foundation

struct Constants {
    static let apiKey = "AIzaSyA66Q93BGaSLlDx6pVeFs-oAFElhvBWi4M"
    static let baseUrl = "https://www.googleapis.com/books/v1/volumes"
    static let categories = ["Fantasy", "History", "Horror", "Journal", "Humor", "Travel", "Drama", "Poetry"]
    static let defaultImage = "https://www.vecteezy.com/vector-art/2219582-vector-illustration-of-book-icon"
}

enum ApiError {
    case failedTogetData
}

class ApiManager {
    static let shared = ApiManager()
    
    func getRecommendedBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)?q=piano+intitle:keyes&key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(RecommendedBooks.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)?q=trending+intitle:keyes&key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(RecommendedBooks.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)?q=fantasy+intitle:keyes&key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(RecommendedBooks.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseUrl)?q=\(query)&key=\(Constants.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(RecommendedBooks.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    ///By ID
    //    func getBookByID(byId id: String, completion: @escaping (Result<Book, Error>) -> Void) {
    //        guard let url = URL(string: "\(Constants.baseUrl)/\(id)") else { return }
    //        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
    //            guard let data = data, error == nil else { return }
    //            do {
    //                let result = try JSONDecoder().decode(Book.self, from: data)
    //                completion(.success(result))
    //            } catch {
    //                completion(.failure(error))
    //            }
    //        }
    //        task.resume()
    //    }
}
