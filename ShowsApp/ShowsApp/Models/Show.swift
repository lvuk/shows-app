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
    
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let premiered: String?
    let schedule: Schedule
}
