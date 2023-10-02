//
//  AsyncImageDetailViewCast.swift
//  ShowsApp
//
//  Created by Luka Vuk on 02.10.2023..
//

import SwiftUI

struct AsyncImageDetailViewCast: View {
    let actor: Person
    var body: some View {
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
    }
}

//struct AsyncImageDetailViewCast_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageDetailViewCast()
//    }
//}
