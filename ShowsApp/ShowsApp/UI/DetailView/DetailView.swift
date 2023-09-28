//
//  DetailView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel = DetailsViewModel()
    let show: Show
    
    var body: some View {
        Text("\(show.name)")
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(show: Show.example)
//    }
//}
