//
//  FavoritesView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel(favoritesService: FavoriteService(persistenceService: PersistenceService()))
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.favoriteShows) { show in
                    Text(show.name)
                }
            }
        }
        .onAppear {
            viewModel.refresh()
        }
    }
        
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
