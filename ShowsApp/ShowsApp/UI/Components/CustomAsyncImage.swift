//
//  CustomAsyncImage.swift
//  ShowsApp
//
//  Created by Luka Vuk on 28.09.2023..
//

import SwiftUI

struct CustomAsyncImage: View {
    let show: Show
    let width: Double
    let height: Double
    
    var body: some View {
        if let imageURL = show.urlOriginalImage {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: width, height: height)
                    
                case .failure:
                    Image(systemName: "xmark.rectangle.portrait.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                @unknown default:
                    EmptyView()
                }
                
            }
            .frame(width: width, height: height)
            .clipped()
        } else {
            Image(systemName: "xmark.rectangle.portrait.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .frame(width: width, height: height)
        }
    }
}

struct CustomAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomAsyncImage(show: .example, width: 200, height: 280)
    }
}
