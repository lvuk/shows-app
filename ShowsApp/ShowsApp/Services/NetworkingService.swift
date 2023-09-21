//
//  NetworkingService.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetch(with request: Request, completion: @escaping (Result<[Show], ErrorHandler>) -> Void)
    func fetchCast(with request: Request, completion: @escaping (Result<[Person], ErrorHandler>) -> Void)
}

final class NetworkingService: ObservableObject, NetworkingServiceProtocol {
    func fetch(with request: Request, completion: @escaping (Result<[Show], ErrorHandler>) -> Void) {
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
                        let searchShowsJSON = try JSONDecoder().decode([SearchShow].self, from: data)
                        let shows = searchShowsJSON.map({ $0.show })
                        completion(.success(shows))
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
    
    func fetchCast(with request: Request, completion: @escaping (Result<[Person], ErrorHandler>) -> Void) {
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
                        let castPersonJSON = try JSONDecoder().decode([CastPerson].self, from: data)
                        let cast = castPersonJSON.map({ $0.person })
                        completion(.success(cast))
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
