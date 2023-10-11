//
//  HomeViewShowComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 02.10.2023..
//

import SwiftUI

struct HomeViewShowComponent: View {
    let show: Show
    let viewModel: HomeViewModel
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading){
                CustomAsyncImage(show: show, width: 200, height: 280)
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
                    .frame(maxWidth: 180, alignment: .leading)
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
