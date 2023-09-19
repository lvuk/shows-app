//
//  SingleShowCellView.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import SwiftUI

struct SingleShowCellView: View {
    
    let show: Show
    var body: some View {
        HStack {
            Image(systemName: "house")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44, alignment: .leading)
            VStack {
                Text(show.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text()
            }
        }
        .padding()
        .background(.red)
    }
}

struct SingleShowCellView_Previews: PreviewProvider {
    static var previews: some View {
        SingleShowCellView(show: Show.example)
    }
}
