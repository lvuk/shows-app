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
        VStack {
            SearchBarView(searchText: $viewModel.searchText) {
                if !viewModel.searchText.isEmpty {
                    viewModel.fetchSearchData(query: viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines))
                } else {
                    viewModel.fetchSearchData(query: "a")
                }
            }
            .padding(.bottom)
            
            Spacer()
            
            ZStack {
                Color.primaryBlack
                    .ignoresSafeArea()
                if viewModel.shows.isEmpty {
                    VStack{
                        Text("You messed up!")
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
            if viewModel.searchText.isEmpty {
                viewModel.fetchSearchData(query: "a")
            } else {
                viewModel.fetchSearchData(query: viewModel.searchText)
            }
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
        .foregroundColor(.white)
        
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
