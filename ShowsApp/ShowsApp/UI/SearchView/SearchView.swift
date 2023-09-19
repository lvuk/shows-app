//
//  SearchView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBlack
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.shows){ show in
                            HStack {
                                
                                AsyncImage(url: viewModel.getImageURL(from: show)) { phase in
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
                                 
                                    
                                    
                                
                                VStack(alignment: .leading) {
                                    Text("\(show.name)")
                                        .font(.headline)
                                    
                                    Text(viewModel.getDate(from: show))
                                        .font(.subheadline)
                                        .opacity(0.5)
                                    
                                    Text(show.genres.joined(separator: ", "))
                                        .font(.subheadline)
                                        .opacity(0.5)
                                }
                                
                            }
                            .padding()
                        }
                    }
                    .padding(.vertical)
                }
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.fetchData(query: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            .onAppear {
                viewModel.fetchData(query: "a")
            }
            .background(Color.primaryDarkGrey)
            .foregroundColor(.primaryWhite)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
    }
}
