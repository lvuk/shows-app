//
//  DetailView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack{
                ZStack(alignment: .topLeading){
                    AsyncImageDetailMain(show: viewModel.show)
//                    FavoriteComponent(show: viewModel.show)
                    Button {
                        print("cliked")
                        viewModel.toggleFavorites()
                    } label: {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .padding(8)
                            .background(Color.primaryDarkGrey)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding([.leading, .top], 5)
                    }
                }
                
                Text("\(viewModel.show.summary?.removeHTMLTag() ?? "" )")
                    .font(.footnote)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                
                HStack(alignment: .lastTextBaseline) {
                    Text("Cast")
                        .font(.title3.bold())
                        
                    
                    Spacer()
                    Button("Show all") {
                        //do smth
                    }
                    .font(.body)
                    .disabled(viewModel.cast.isEmpty)
                }
                .padding(.horizontal, 10)
            }
            
            if viewModel.cast.isEmpty {
                Text("No information to display")
                    .padding()
                    .opacity(0.5)
                
            } else {
                ZStack{
                    Color.primaryDarkGrey
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center){
                            ForEach(viewModel.cast) { actor in
                                VStack {
                                    AsyncImageDetailViewCast(actor: actor)
                                    Text(actor.name)
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                        

                    }
                }
            }
        }
        .background(Color.black)
        .navigationTitle(viewModel.show.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCast(id: viewModel.show.id)
            print(viewModel.cast)
            print(viewModel.show.id)
        }
        .preferredColorScheme(.dark)
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(viewModel: DetailsViewModel(show: .example, favoriteService: ))
//    }
//}
