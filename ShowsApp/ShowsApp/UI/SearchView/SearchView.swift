//
//  SearchView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(searchText: $viewModel.searchText) {
                    if !viewModel.searchText.isEmpty {
                        viewModel.fetchSearchData(query: viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines))
                    } else {
                        viewModel.fetchSearchData(query: "a")
                    }
                }
                .padding()
                
                ZStack {
                    Color.primaryBlack
                    if viewModel.shows.isEmpty {
                        VStack{
                            Text("You fucked up!")
                                .font(.title)
                                .foregroundColor(.primaryLightGrey)
                            Text("There is no movie named '\(viewModel.searchText)'")
                                .foregroundColor(.primaryLightGrey)
                        }
                    } else {
                       SearchListView(viewModel: viewModel)
                    }
                }
            }
            .onAppear {
                viewModel.fetchSearchData(query: "a")
            }
            .onChange(of: viewModel.searchText, perform: { newText in
                if(newText.isEmpty) {
                    viewModel.fetchSearchData(query: "a")
                } else {
                    viewModel.fetchSearchData(query: newText)
                }
            })
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
