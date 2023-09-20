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
            VStack {
                SearchBarView(searchText: $searchText) {
                    if !searchText.isEmpty {
                        viewModel.fetchData(query: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
                    } else {
                        viewModel.fetchData(query: "a")
                    }
                }
                .padding()
                
                ZStack {
                    Color.primaryBlack
                    if viewModel.shows.isEmpty {
                        Text("You fucked up!")
                            .font(.title)
                            .foregroundColor(.primaryLightGrey)
                        Text("There is no movie named '\(searchText)'")
                            .foregroundColor(.primaryLightGrey)
                    } else {
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
                                            
                                            Text(show.genres.joined(separator: ", "))
                                                .font(.subheadline)
                                                .opacity(0.5)
                                        }
                                        
                                    }
                                    .padding()
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchData(query: "a")
            }
            .onTapGesture {
                //dismiss keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .background(Color.primaryDarkGrey)
            .foregroundColor(.primaryWhite)
        }
        .preferredColorScheme(.dark)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
