//
//  FavoritesViewComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 16.10.2023..
//

import SwiftUI

struct FavoritesViewComponent: View {
    let show: Show
    @State var isFavorite = false
    let favoriteService: FavoriteServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol, show: Show) {
        self.favoriteService = favoriteService
        self.show = show
    }
    
    func refresh() {
        isFavorite = favoriteService.isFavorite(show: show)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading){
                CustomAsyncImage(show: show, width: 190, height: 260)

                Button {
                    isFavorite.toggle()

                    if !isFavorite {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showUnfavorited"), object: show)
                    }
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
                    .frame(maxWidth: 169, alignment: .leading)
            }
            .padding(.leading, 10)
        }
        .background(Color.primaryDarkGrey)
        .cornerRadius(10)
        .onAppear {
            isFavorite = favoriteService.isFavorite(show: show)
        }
    }
}

//struct FavoritesViewComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesViewComponent()
//    }
//}
