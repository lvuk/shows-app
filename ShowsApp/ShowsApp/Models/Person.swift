//
//  Person.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import Foundation

struct CastPerson: Codable {
    let person: Person
}

struct Person: Identifiable, Codable {
    let id: Int
    let name: String
}
