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
                    SearchListComponent(viewModel: viewModel, show: show)
                }
            }
            .padding(.vertical, 10)
        }
        .preferredColorScheme(.dark)
    }
}
