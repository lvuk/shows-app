//
//  NetworkConfiguration.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import Foundation

struct NetworkConfiguration {
    let baseURL: String
    let staticHeaders: [String: String]? = nil
    let authorizationHeaders: [String: String]? = nil
}

enum HTTPMethod: String {
    case get, post
}

enum RequestType: String {
    case json = "Application/json; charset=utf-8"
    case query = "Application/x-www-form-urlencoded; charset=utf-8"
}

enum ErrorHandler: Error {
    case cannotParse
    case notFound
    case other(Int)
    
    init(code: Int) {
        switch code {
        case 404: self = .notFound
        default: self = .other(code)
        }
    }
}

struct Request {
    let path: String
    let method: HTTPMethod
    let type: RequestType
    let parameters: [String: Any]?
    let query: String?
}

