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
                if let imageURL = show.urlOriginalImage {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .ignoresSafeArea()
                                
                        case .failure:
                            Image(systemName: "xmark.rectangle.portrait.fill")
                                .resizable()
                                .scaledToFit()
                        @unknown default:
                            EmptyView()
                        }
                        
                    }
                } else {
                    Image(systemName: "xmark.rectangle.portrait.fill")
                            .resizable()
                            .scaledToFit()
                }
                Text("\(show.summary ?? "" )")
                    .font(.footnote)
                    .padding(.vertical, 3)
                
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
            }
            
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(viewModel.cast) { actor in
                        VStack {
                            if let imageURL = actor.urlMediumImage {
                                AsyncImage(url: imageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .ignoresSafeArea()
                                            .frame(width: 100, height: 100)
                                            
                                    case .failure:
                                        Image(systemName: "xmark.rectangle.portrait.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .ignoresSafeArea()
                                            .frame(width: 100, height: 100)
                                    @unknown default:
                                        EmptyView()
                                    }
                                    
                                }
                            } else {
                                Image(systemName: "xmark.rectangle.portrait.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .ignoresSafeArea()
                                    .frame(width: 100, height: 100)
                            }
                            Text(actor.name)
                                .font(.subheadline)
                        }
                        
                    }
                }
                .padding(.vertical, 10)
//                .padding(.bottom, 5)
                
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
            print(show.id
            )
        }
        .preferredColorScheme(.dark)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(show: Show.example)
    }
}
