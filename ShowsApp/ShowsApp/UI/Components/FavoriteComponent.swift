//
//  FavoriteComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 04.10.2023..
//

import SwiftUI

struct FavoriteComponent: View {
    let show: Show
    let viewModel = FavoritesViewModel(favoritesService: FavoriteService(persistenceService: PersistenceService()))
    
    var body: some View {
        Button {
            print("cliked")
            viewModel.toggleFavorites(show: show)
        } label: {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(8)
                .background(Color.primaryDarkGrey)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding([.leading, .top], 5)
        }
    }
}
