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
        ScrollView {
            VStack{
                ZStack(alignment: .topLeading){
                    AsyncImageDetailMain(show: show)
                    FavoriteComponent()
                        .onTapGesture {
                            //
                        }
                }
                
                Text("\(show.summary?.removeHTMLTag() ?? "" )")
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
                        HStack{
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
        .navigationTitle(show.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCast(id: show.id)
            print(viewModel.cast)
            print(show.id)
        }
        .preferredColorScheme(.dark)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(show: Show.example)
    }
}
