//
//  Show.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import Foundation
import SwiftUI

struct SearchShow: Codable {
    let show: Show
}

struct Show: Codable, Identifiable {
    struct Schedule: Codable {
        let time: String
        let days: [String]
    }
    
    struct Image: Codable {
        let medium: String
        let original: String
    }
    
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let premiered: String?
    let schedule: Schedule
    let image: Image?
    
    var urlImage: URL? {
        guard let image = image else { return nil }
        return URL(string: image.medium)
    }
    
    var premieredYear: String {
        guard let premiered = premiered else { return "N/A"}
        let date = premiered.split(separator: "-")
        let year = date[0]
        
        return String(year)
    }
}
