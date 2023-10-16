//
//  FavoriteComponentViewModel.swift
//  ShowsApp
//
//  Created by Luka Vuk on 13.10.2023..
//

import Foundation
import SwiftUI


final class FavoriteComponentViewModel: ObservableObject {
    let show: Show
    private let favoriteService: FavoriteServiceProtocol = ServiceFactory().favoriteService
    private var favoritesViewModel: FavoritesViewModel? = nil
    
    @Published var isFavorite: Bool
    
    init(show: Show) {
        self.show = show
        self.isFavorite = favoriteService.isFavorite(show: show)
    }
    
    init(show: Show, favoritesViewModel: FavoritesViewModel?) {
        self.show = show
        self.favoritesViewModel = favoritesViewModel
        self.isFavorite = favoriteService.isFavorite(show: show)
    }
    
    func toggleFavorite() {
        withAnimation {
            favoriteService.toggleFavorite(show: show)
            isFavorite.toggle()
            favoritesViewModel?.refresh()
        }
        print(favoritesViewModel?.favoriteShows.count)
    }
    
    func refresh() {
        favoritesViewModel?.refresh()
    }
}
