//
//  FavoriteComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 04.10.2023..
//

import SwiftUI

struct FavoriteComponent: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 32, height: 32)
                .foregroundColor(.primaryDarkGrey)
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .foregroundColor(isFavorite ? Color.primaryYellow : Color.primaryLightGrey)
        }
        .padding([.leading, .top], 5)
    }
}
