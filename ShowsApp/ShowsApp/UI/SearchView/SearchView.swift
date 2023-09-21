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
                        VStack{
                            Text("You fucked up!")
                                .font(.title)
                                .foregroundColor(.primaryLightGrey)
                            Text("There is no movie named '\(searchText)'")
                                .foregroundColor(.primaryLightGrey)
                        }
                    } else {
                       SearchListView(viewModel: viewModel)
                    }
                }
            }
            .onAppear {
                viewModel.fetchData(query: "a")
            }
            .onChange(of: searchText, perform: { newText in
                if(newText.isEmpty) {
                    viewModel.fetchData(query: "a")
                } else {
                    viewModel.fetchData(query: newText)
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
