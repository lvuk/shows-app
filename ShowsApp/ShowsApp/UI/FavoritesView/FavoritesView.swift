//
//  FavoritesView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    
    var body: some View {
        if viewModel.favoriteShows.isEmpty {
            VStack {
                Text("Your favorites list is empty")
                    .font(.title3.bold())
                Text("Try adding one in Home Tab")
                    .font(.subheadline)
            }
            .opacity(0.6)
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.refresh()
            }
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.favoriteShows) { show in
                        VStack(alignment: .leading) {
                            ZStack(alignment: .topLeading){
                                CustomAsyncImage(show: show, width: 180, height: 260)
                                FavoriteComponent(viewModel: FavoriteComponentViewModel(show: show, favoritesViewModel: viewModel))
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
                    print(viewModel.favoriteShows.count)
                }
                .navigationTitle("Favorites")
            }
        }
    }
        
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
