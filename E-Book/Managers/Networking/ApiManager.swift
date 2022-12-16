//
//  ApiManager.swift
//  E-Book
//
//  Created by  Sasha Khomenko on 28.11.2022.
//

import Foundation

struct ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func getRecommendedBooks(completion: @escaping(Result<[Book], Error>) -> Void) {
        request(route: .getRecommendedBooks, method: .get, completion: completion)
    }
    
    func getTrendingBooks(completion: @escaping(Result<[Book], Error>) -> Void) {
        request(route: .getTrendingBooks, method: .get, completion: completion)
    }
    
    func getTopBooks(completion: @escaping(Result<[Book], Error>) -> Void) {
        request(route: .getTopBooks, method: .get, completion: completion)
    }
    
    func getSearchView(type: String, orderBy: String?, filter: String?, completion: @escaping(Result<[Book], Error>) -> Void) {
        request(route: .getSearchView(type, orderBy, filter), method: .get, completion: completion)
    }
    
    func search(with query: String, type: String, orderBy: String?, filter: String?, completion: @escaping(Result<[Book], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        request(route: .search(query, type, orderBy, filter), method: .get, completion: completion)
    }
    
//    func getBookByID(with id: String, completion: @escaping(Result<Book, Error>) -> Void) {
//        request(route: .getBookByID(id), method: .get, completion: completion)
//    }

    
    private func request<T: Codable> (route: Route,
                                      method: Method,
                                      completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                handleResponse(result: result, completion: completion )
            }
        }.resume()
    }
    
    private func handleResponse<T:Codable> (result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(RecommendedBooks.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            completion(.success(response.items as! T))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: the path the the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route: Route, method: Method, parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Constants.baseUrl + route.discription + Constants.apiKey
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
