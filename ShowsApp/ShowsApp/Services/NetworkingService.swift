//
//  NetworkingService.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetch<T:Codable>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T:Codable

    func fetchSearchData(query: String, completion: @escaping (Result<[SearchShow], ErrorHandler>) -> Void)
    func fetchCastData(id: Int, completion: @escaping (Result<[Cast], ErrorHandler>) -> Void)
}

final class NetworkingService: ObservableObject, NetworkingServiceProtocol {
    func fetch<T:Codable>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T:Codable {
        guard let urlRequest =  configureRequest(request) else { return }
        let urlSession: URLSession = URLSession.shared
        
        // Create a data task
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            // Check for a successful HTTP response (status code 200)
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let data = data {
                    // Parse the data
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                    }
                    catch {
                        print("Error: \(error)")
                        completion(.failure(.cannotParse))
                        return
                    }
                }
            }
            else {
                print("Error: \(httpResponse.statusCode)")
                completion(.failure(.notFound))
            }
        }
        .resume()
    }
    
    func fetchSearchData(query: String, completion: @escaping (Result<[SearchShow], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/search/shows?q=",
            method: .get,
            type: .json,
            parameters: nil,
            query: query)
        
        fetch(of: [SearchShow].self, with: request) { result in
            switch result {
            case .success(let searchShows):
                print("SUCCESS: search shows passed")
                completion(.success(searchShows))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCastData(id: Int, completion: @escaping (Result<[Cast], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/shows/\(id)/cast",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)
        
        fetch(of: [Cast].self, with: request) { result in
            switch result {
            case .success(let cast):
                print("SUCCESS: cast passed")
                completion(.success(cast))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
        
    }
    

}

extension NetworkingService {
    func configureRequest(_ request: Request) -> URLRequest? {
        let configuration: NetworkConfiguration = NetworkConfiguration(baseURL: "https://api.tvmaze.com")
        let urlString = configuration.baseURL + request.path
        
        guard let url = URL(string: urlString) else {
            print("Error creating request URL with: \(urlString)")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(request.type.rawValue, forHTTPHeaderField: "Content-Type")
        
        ///Headers
        if let headers = configuration.staticHeaders {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        ///Auth header
        if let authorization = configuration.authorizationHeaders {
            for (key, value) in authorization {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        ///Parameters & query
        if let parameters = request.parameters {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }

        if let query = request.query {
            urlRequest.url = URL(string: urlString.appending(query))
        }
        
        return urlRequest
    }
}
