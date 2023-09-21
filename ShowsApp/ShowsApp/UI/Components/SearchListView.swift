//
//  SearchListView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 20.09.2023..
//

import SwiftUI

struct SearchListView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.shows){ show in
                    HStack {
                        AsyncImage(url: show.urlImage) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 66, height: 44)
                            case .failure:
                                Image(systemName: "xmark.rectangle.portrait.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                            @unknown default:
                                EmptyView()
                            }
                            
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
                                    if cast.count > 2 {
                                        Text("And more")
                                            .font(.subheadline)
                                            .opacity(0.7)
                                    }
                                }
                            }
                            
                            Text(show.genres.joined(separator: ", "))
                                .font(.subheadline)
                                .opacity(0.5)
                        }
                        .padding(.horizontal, 1)
                        
                    }
                    .padding()
                }
            }
            .padding(.vertical, 10)
        }
        .preferredColorScheme(.dark)
    }
}
