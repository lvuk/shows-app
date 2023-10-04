//
//  Colors.swift
//  ShowsApp
//
//  Created by Luka Vuk on 19.09.2023..
//

import Foundation
import SwiftUI

extension Color {
    static let primaryBlack = Color("PrimaryBlack")
    static let primaryDarkGrey = Color("PrimaryDarkGrey")
    static let primaryLightGrey = Color("PrimaryLightGrey")
    static let primaryWhite = Color("PrimaryWhite")
    static let primaryYellow = Color("PrimaryYellow")
}

extension String {
   func removeHTMLTag() -> String {
       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }

}
