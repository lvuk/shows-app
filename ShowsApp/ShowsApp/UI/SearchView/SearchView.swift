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
                List {
                    ForEach(viewModel.shows){ show in
                        HStack {
                            Image(systemName: "house")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33, alignment: .leading)
                                .padding()
                            
                            VStack(alignment: .leading) {
                                Text("\(show.name)")
                                    .font(.headline)
                                
                                Text(viewModel.getDate(from: show))
                                
                                Text(show.genres.joined(separator: ", "))
                                    .font(.subheadline)
                            }
                            
                        }
                    }
                }
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    viewModel.fetchData(query: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
                }
                
            }
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
