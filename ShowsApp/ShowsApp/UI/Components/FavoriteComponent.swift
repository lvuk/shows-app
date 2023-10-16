//
//  FavoriteComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 04.10.2023..
//

import SwiftUI

struct FavoriteComponent: View {
    @ObservedObject var viewModel: FavoriteComponentViewModel
    
    var body: some View {
        Button {
            viewModel.toggleFavorite()
        } label: {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
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
