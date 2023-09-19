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
    @Published var showObject: Show?
    @Published var shows = [Show]()
}

extension SearchViewModel{
    func fetchData() {
        let request = Request(
            path: "/search/shows?q=girls",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil)

        networkinService.fetch(with: request) { [weak self] result in
            switch result {
            case .success(let shows):
                print("SUCCESS: \(shows)")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}

