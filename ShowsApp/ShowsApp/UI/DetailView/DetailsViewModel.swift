//
//  DetailsViewModel.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import Foundation
import SwiftUI


final class DetailsViewModel: ObservableObject {
    @ObservedObject var networkingService = NetworkingService()
    
    @Published var show: Show
    @Published var isFavorite: Bool
    @Published var cast: [Person] = [Person]()
    
    private let favoriteService: FavoriteServiceProtocol
    init(show: Show, favoriteService: FavoriteServiceProtocol) {
       self.favoriteService = favoriteService
       self.show = show
       self.isFavorite = favoriteService.isFavorite(show: show)
   }
    
    func toggleFavorites() {
        isFavorite = favoriteService.toggleFavorite(show: show).isAdded
        objectWillChange.send()
    }
            
    func refresh() {
        isFavorite = favoriteService.isFavorite(show: show)
    }
    
}

extension DetailsViewModel {
    func fetchCast(id: Int) {
        networkingService.fetchCastData(id: id){ [weak self] result in
            switch result {
            case .success(let cast):
                DispatchQueue.main.async {
                    self?.cast = cast.map { $0.person }
                }
                print("SUCCESS: \(String(describing: cast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
