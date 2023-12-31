//
//  HomeViewShowComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 02.10.2023..
//

import SwiftUI

struct HomeViewShowComponent: View {
    let show: Show
    let favoriteService: FavoriteServiceProtocol
    
    @State var isFavorite = false
    @State private var favorites: [Show]
    
    init(favoriteService: FavoriteServiceProtocol, show: Show) {
        self.favoriteService = favoriteService
        self.show = show
        _favorites = State(initialValue: favoriteService.favorites)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading){
                CustomAsyncImage(show: show, width: 200, height: 280)
                
                Button {
                    isFavorite.toggle()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favorite"), object: isFavorite)
                    
                    _ = favoriteService.toggleFavorite(show: show)
                } label: {
                    FavoriteComponent(isFavorite: $isFavorite)
                }
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
                    .frame(maxWidth: 180, alignment: .leading)
            }
            .padding(.leading, 10)
        }
        .background(Color.primaryDarkGrey)
        .onAppear {
            isFavorite = favoriteService.isFavorite(show: show)
        }
        .cornerRadius(10)
    }
}
