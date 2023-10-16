//
//  HomeViewScheduleComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 03.10.2023..
//

import SwiftUI

struct HomeViewScheduleComponent: View {
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
                CustomAsyncImage(show: show, width: 160, height: 200)
                
                Button {
                    isFavorite.toggle()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favorite"), object: isFavorite)
                    
                    _ = favoriteService.toggleFavorite(show: show)
                } label: {
                    FavoriteComponent(isFavorite: $isFavorite)
                }
            }
            
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Text("\(show.airtime ?? "N/A")")
                        .font(.caption)
                }
                Text("\(show.name)")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(Color.primaryWhite)
                    .opacity(0.7)
                    .padding(.bottom)
                    .frame(maxWidth: 140, alignment: .leading)
            }
            .padding(.horizontal, 10)
        }
        .background(Color.primaryDarkGrey)
        .cornerRadius(10)
        .onAppear {
            isFavorite = favoriteService.isFavorite(show: show)
        }
    }
}
