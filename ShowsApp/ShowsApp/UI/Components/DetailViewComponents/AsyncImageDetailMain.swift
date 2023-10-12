//
//  AsyncImageDetailMain.swift
//  ShowsApp
//
//  Created by Luka Vuk on 02.10.2023..
//

import SwiftUI

struct AsyncImageDetailMain: View {
    let show: Show
    var body: some View {
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
                    .frame(width: 80, height: 120)
                    .frame(width: 350, height: 400)
                    
        }
    }
}

struct AsyncImageDetailMain_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageDetailMain(show: .example)
    }
}
