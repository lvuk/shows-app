//
//  SearchBarView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 20.09.2023..
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(Color.primaryLightGrey)
            
            TextField("", text: $searchText, prompt: Text("Search").foregroundColor(Color.gray))
                .foregroundColor(.black)
                .focused($isFocused)
                .submitLabel(.search)
                .onSubmit(action)
            
            if isFocused {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.headline)
                        .foregroundColor(Color.primaryLightGrey)
                }
            }
            
        }
        .padding(10)
        .background(Color.primaryWhite)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1)
        }

    }
}

