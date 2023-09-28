//
//  Person.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import Foundation

struct Cast: Codable {
    let person: Person
}

struct Person: Identifiable, Codable {
    let id: Int
    let name: String
    let image: PersonImage?
    
    var urlMediumImage: URL? {
        guard let image = image else { return nil }
        return URL(string: image.medium)
    }
    
    var urlOriginalImage: URL? {
        guard let image = image else { return nil }
        return URL(string: image.original)
    }
}
