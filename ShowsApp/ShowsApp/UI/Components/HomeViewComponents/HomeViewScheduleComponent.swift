//
//  HomeViewScheduleComponent.swift
//  ShowsApp
//
//  Created by Luka Vuk on 03.10.2023..
//

import SwiftUI

struct HomeViewScheduleComponent: View {
    let show: Show
    let viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomAsyncImage(show: show, width: 160, height: 200)
            
            VStack(alignment: .leading) {
                Text("\(show.airtime ?? "N/A")")
                    .font(.caption)
                Text("\(show.name)")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(Color.primaryWhite)
                    .opacity(0.7)
                    .padding(.bottom)
                    .frame(maxWidth: 140, alignment: .leading)
            }
            .padding(.leading, 10)
        }
        .background(Color.primaryDarkGrey)
        .cornerRadius(10)
        .onTapGesture {
            viewModel.onShowTapped?(show)
        }
    }
}

//struct HomeViewScheduleComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeViewScheduleComponent(show: .example, viewModel: HomeViewModel())
//    }
//}
