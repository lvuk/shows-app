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
                        FavoritesViewComponent(favoriteService: viewModel.favoritesService, show: show)
                            .onTapGesture {
                                viewModel.onShowTapped?(show)
                            }
                    }
                }
//                .padding(.horizontal, 5)
                .onAppear {
                    viewModel.refresh()
                }
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name(rawValue: "showUnfavorited"))) { _ in
                    withAnimation {
                        viewModel.refresh()
                    }
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
