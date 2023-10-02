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
                AsyncImageDetailMain(show: show)
                
                Text("\(show.summary ?? "" )")
                    .font(.footnote)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Cast")
                        .font(.title3.bold())
                        
                    
                    Spacer()
                    Button("Show all") {
                        //do smth
                    }
                    .foregroundColor(.primaryYellow)
                    .font(.body)
                }
                .padding(.horizontal, 10)
            }
            
                
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
                .background(Color.primaryDarkGrey)

            }
        }
        .background(Color.black)
        .navigationTitle(show.name)
        .foregroundColor(.white)
        .toolbarBackground(Color.primaryDarkGrey, for: .navigationBar)
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
