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
    @Published var searchText = ""
    
    @Published var shows: [Show] = [Show]()
    @Published var showCasts: [Int: [Person]] = [:]
}


extension SearchViewModel{
    func fetchSearchData(query: String) {
        networkinService.fetchSearchData(query: query) { [weak self] result in
            switch result {
            case .success(let searchShows):
                DispatchQueue.main.async {
                    let shows = searchShows.map { $0.show }
                    for show in shows {
                        self?.fetchCast(id: show.id)
                    }
                    self?.shows = shows
                }
                print("SUCCESS: \(String(describing: self?.shows))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCast(id: Int) {
        networkinService.fetchCastData(id: id){ [weak self] result in
            switch result {
            case .success(let cast):
                DispatchQueue.main.async {
                    self?.showCasts[id] = cast.map { $0.person }
                }
                print("SUCCESS: \(String(describing: cast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

