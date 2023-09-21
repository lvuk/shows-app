//
//  SearchViewModel.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    @ObservedObject var networkinService = NetworkingService()
    @Published var shows: [Show] = [Show]()
    @Published var showCasts: [Int: [Person]] = [:]
}


extension SearchViewModel{
    func fetchData(query: String) {
        let request = Request(
            path: "/search/shows?q=\(query)",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)

        networkinService.fetch(with: request) { [weak self] result in
            switch result {
            case .success(let shows):
                DispatchQueue.main.async {
                    self?.shows = shows
                    for show in shows {
                        self?.fetchCastData(id: show.id)
                    }
                }
                print("SUCCESS: \(String(describing: self?.shows))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCastData(id: Int) {
        let request = Request(
            path: "/shows/\(id)/cast",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)
        
        networkinService.fetchCast(with: request) { [weak self] result in
            switch result {
            case .success(let cast):
                DispatchQueue.main.async {
                    self?.showCasts[id] = cast
                }
                print("SUCCESS: \(String(describing: cast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

