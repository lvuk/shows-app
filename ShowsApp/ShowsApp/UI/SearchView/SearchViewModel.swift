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
    
    
    func getDate(from show: Show) -> String {
        guard let premiered = show.premiered else { return "N/A"}
        let date = premiered.split(separator: "-")
        let year = date[0]
        
        return String(year)
    }
    
    func getImageURL(from show: Show) -> URL? {
        return URL(string: show.image?.original ?? "")
    }
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
                    print("SUCCESS: \(String(describing: self?.shows))")
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

