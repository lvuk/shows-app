//
//  HomeViewModel.swift
//  ShowsApp
//
//  Created by Luka Vuk on 28.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class HomeViewModel: ObservableObject {
    @ObservedObject var networkingService = NetworkingService()
    
    @Published var shows: [Show] = [Show]()
    @Published var schedule: [Show] = [Show]()
    
    var onShowTapped: ((Show) -> Void)?
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        
        return today
    }
    
    private let favoritesService: FavoriteServiceProtocol
    
    init(favoritesService: FavoriteServiceProtocol) {
        self.favoritesService = favoritesService
    }
}

extension HomeViewModel {
    func fetchSearchData(query: String) {
        networkingService.fetchSearchData(query: query) { [weak self] result in
            switch result {
            case .success(let searchShows):
                DispatchQueue.main.async {
                    self?.shows = searchShows.map { $0.show }
                }
                print("SUCCESS: Shows")
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchScheduleData(date: String) {
        networkingService.fetchScheduleData(date: date) { [weak self] result in
            switch result {
            case .success(let scheduleShowsResponse):
                DispatchQueue.main.async {
                    let shows = scheduleShowsResponse.map { $0.show }
                    
                    for i in 0..<shows.count {
                        var scheduleShow = shows[i]
                        scheduleShow.airtime = scheduleShowsResponse[i].airtime
                        self?.schedule.append(scheduleShow)
                    }
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
