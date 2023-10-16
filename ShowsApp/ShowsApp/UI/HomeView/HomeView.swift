//
//  HomeView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .leading){
                ScrollView {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.shows) { show in
                                    HomeViewShowComponent(favoriteService: viewModel.favoritesService, show: show)
                                        .onTapGesture {
                                            viewModel.onShowTapped?(show)
                                        }
                                }
                            }
                        }
                        
                        HStack(alignment: .lastTextBaseline) {
                            Text("Schedule")
                                .font(.title2)
                            Spacer()
                            
                            Button {
                                //do smth
                            } label: {
                                Text("Show all")
                                    .foregroundColor(.primaryYellow)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(viewModel.schedule) { show in
                                    HomeViewScheduleComponent(favoriteService: viewModel.favoritesService, show: show)
                                }
                            }
                            .padding(.bottom, 10)
                        }

                    }
                    .onAppear {
                        viewModel.fetchSearchData(query: "Simpsons")
                        viewModel.fetchScheduleData(date: viewModel.getDate())
                        print(viewModel.shows.count)
                    }
                }
            }
        }
        .navigationTitle("Shows")
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//            HomeView(viewModel: HomeViewModel(favoritesService: FavoriteService(persistenceService: PersistenceService())))
//    }
//}
