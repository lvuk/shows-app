//
//  FavoriteComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 04.10.2023..
//

import SwiftUI

struct FavoriteComponent: View {
    var body: some View {
        Button {
            // add to favorites
        } label: {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(8)
                .background(Color.primaryDarkGrey)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    
                }
                .padding([.leading, .top], 5)
        }
    }
}

struct FavoriteComponent_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteComponent()
    }
}
