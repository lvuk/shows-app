//
//  CustomAsyncImage.swift
//  ShowsApp
//
//  Created by Luka Vuk on 28.09.2023..
//

import SwiftUI

struct CustomAsyncImage: View {
    let show: Show
    var body: some View {
        if let imageURL = show.urlOriginalImage {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                case .failure:
                    Image(systemName: "xmark.rectangle.portrait.fill")
                @unknown default:
                    EmptyView()
                }
                
            }
        } else {
            Image(systemName: "xmark.rectangle.portrait.fill")
        }
    }
}

struct CustomAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomAsyncImage(show: .example)
    }
}
