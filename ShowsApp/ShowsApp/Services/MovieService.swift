//
//  MovieService.swift
//  ShowsApp
//
//  Created by Luka Vuk on 09.10.2023..
//

import Foundation

protocol MovieServiceProtocol {
    func getSearchedMovies(query: String) async ->  Result<[Show], Error>
}

enum MovieError: Error {
    case general
}

extension MovieError: LocalizedError {
    public var errorDescription: String? {
       switch self {
       case .general:
           return NSLocalizedString("Something went wrong!", comment: "General error")
       }
   }
}


class MovieService: MovieServiceProtocol {
//    func getTopMovies() async ->  Result<[Show], Error> {
//        guard Int.random(in: 1..<5) != 3 else {
//            return .failure(MovieError.general)
//        }
//        let movies = MockedMovies.allMovies.prefix(Int.random(in: 1..<10))
//        return .success(movies.shuffled())
//    }
    func getSearchedMovies(query: String) async -> Result<[Show], Error> {
        <#code#>
    }
}
