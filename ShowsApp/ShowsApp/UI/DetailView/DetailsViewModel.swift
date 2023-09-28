//
//  DetailsViewModel.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import Foundation
import SwiftUI


final class DetailsViewModel: ObservableObject {
    @ObservedObject var networkingService = NetworkingService()
    
    @Published var cast: [Person] = [Person]()
    
}

extension DetailsViewModel {
    func fetchCast(id: Int) {
        networkingService.fetchCastData(id: id){ [weak self] result in
            switch result {
            case .success(let cast):
                DispatchQueue.main.async {
                    self?.cast = cast.map { $0.person }
                }
                print("SUCCESS: \(String(describing: cast))")
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
