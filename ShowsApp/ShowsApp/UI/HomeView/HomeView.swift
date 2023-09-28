//
//  HomeView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        Text("HOME")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
