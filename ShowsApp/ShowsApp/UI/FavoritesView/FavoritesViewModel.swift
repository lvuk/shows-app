//
//  FavoritesViewModel.swift
//  ShowsApp
//
//  Created by Luka Vuk on 28.09.2023..
//

import Foundation
import SwiftUI
import UIKit

final class FavoritesViewModel: ObservableObject {
    @ObservedObject var networkinService = NetworkingService()
    
    @Published var favoriteShows: [Show] = [Show]()
    @Published var favoritesShowCast: [Int: [Person]] = [:]
    
    var onShowTapped: ((Show) -> Void)?
    
    private let favoritesService: FavoriteServiceProtocol
    
    init(favoritesService: FavoriteServiceProtocol) {
        self.favoritesService = favoritesService
        favoriteShows = favoritesService.favorites
    }
    
    func refresh() {
        favoriteShows = favoritesService.favorites
    }
    
    func toggleFavorites(show: Show) {
        
    }
}

extension FavoritesViewModel {
    func fetchCast(id: Int) {
        networkinService.fetchCastData(id: id){ [weak self] result in
            switch result {
            case .success(let cast):
                DispatchQueue.main.async {
                    self?.favoritesShowCast[id] = cast.map { $0.person }
                }
                print("SUCCESS: \(String(describing: cast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
