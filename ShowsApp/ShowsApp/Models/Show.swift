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

struct PersonImage: Codable {
    let medium: String
    let original: String
}

struct Show: Codable, Identifiable {
    struct Schedule: Codable {
        let time: String
        let days: [String]
    }

    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let premiered: String?
    let summary: String?
    let schedule: Schedule
    let image: PersonImage?
    
    var urlMediumImage: URL? {
        guard let image = image else { return nil }
        return URL(string: image.medium)
    }
    
    var urlOriginalImage: URL? {
        guard let image = image else { return nil }
        return URL(string: image.original)
    }
    
    var premieredYear: String {
        guard let premiered = premiered else { return "N/A"}
        let date = premiered.split(separator: "-")
        let year = date[0]
        
        return String(year)
    }
    
    static let example = Show(id: 1, url: "https://www.tvmaze.com/shows/1/under-the-dome", name: "Under The Dome", type: "Scripted", language: "English", genres: ["Drama", "Thriller"], premiered: "2013-06-24", summary: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>", schedule: Schedule(time: "22:00", days: ["Thursday"]), image: PersonImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg", original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"))
}
