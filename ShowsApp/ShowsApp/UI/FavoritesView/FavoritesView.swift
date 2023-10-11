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
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.favoriteShows) { show in
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading){
                            CustomAsyncImage(show: show, width: 180, height: 260)
                            FavoriteComponent(show: show)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.primaryYellow)
                                
                                Text("\(show.rating?.average?.formatted() ?? "N/A")")
                                    .font(.system(size: 14))
                            }
                            
                            Text("\(show.name)")
                                .font(.subheadline)
                                .lineLimit(1)
                                .foregroundColor(Color.primaryWhite)
                                .opacity(0.7)
                                .padding(.bottom)
                                .frame(maxWidth: 160, alignment: .leading)
                        }
                        .padding(.leading, 10)
                    }
                    .background(Color.primaryDarkGrey)
                    .cornerRadius(10)
                    .onTapGesture {
                        viewModel.onShowTapped?(show)
                    }
                }
            }
            .padding(.horizontal, 5)
            .onAppear {
                viewModel.refresh()
            }
            .navigationTitle("Favorites")
        }
    }
        
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
