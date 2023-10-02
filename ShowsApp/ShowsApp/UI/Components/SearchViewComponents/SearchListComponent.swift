//
//  SearchListComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import SwiftUI

struct SearchListComponent: View {
    @ObservedObject var viewModel: SearchViewModel
    let show: Show
    
    var body: some View {
        Button {
            //do smth
            print("tapped")
            viewModel.onShowTapped?(show)
        } label: {
            HStack {
                if let imageURL = show.urlMediumImage {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 64, height: 84)
                        case .failure:
                            Image(systemName: "xmark.rectangle.portrait.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 84)
                        @unknown default:
                            EmptyView()
                        }
                        
                    }
                } else {
                    Image(systemName: "xmark.rectangle.portrait.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 84)
                }

                 
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(show.name)")
                        .font(.headline)
                    
                    Text(show.premieredYear)
                        .font(.subheadline)
                        .opacity(0.5)
                    
                    if let cast = viewModel.showCasts[show.id] {
                        HStack{
                            ForEach(cast.prefix(2)) { actor in
                                Text(actor.name)
                                    .font(.subheadline)
                                    .opacity(0.5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 1)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.primaryLightGrey)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
    }
}
