//
//  ApiManager.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 28.11.2022.
//

import Foundation

struct Constants {
    static let apiKey = "AIzaSyA66Q93BGaSLlDx6pVeFs-oAFElhvBWi4M"
    static let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="
}

enum ApiError {
    case failedTogetData
}

class ApiManager {
    static let shared = ApiManager()
    
    func getRecommendedBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)piano+intitle:keyes&key=\(Constants.apiKey)") else { return }
        
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
        guard let url = URL(string: "\(Constants.baseUrl)trending+intitle:keyes&key=\(Constants.apiKey)") else { return }
        
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
        guard let url = URL(string: "\(Constants.baseUrl)fantasy+intitle:keyes&key=\(Constants.apiKey)") else { return }
        
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
        guard let url = URL(string: "\(Constants.baseUrl)\(query)&key=\(Constants.apiKey)") else { return }
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
}
