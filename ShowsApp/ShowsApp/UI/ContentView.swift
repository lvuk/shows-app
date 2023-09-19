//
//  ContentView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 18.09.2023..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            Button("Click me") {
                viewModel.fetchData()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
