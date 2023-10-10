//
//  ServiceFactory.swift
//  ShowsApp
//
//  Created by Luka Vuk on 10.10.2023..
//

import Foundation

class ServiceFactory {
    lazy var favoriteService: FavoriteServiceProtocol = {
        FavoriteService(persistenceService: persistenceService)
    }()
    
    lazy var persistenceService: FavoritesPersistenceServiceProtocol  = {
        PersistenceService()
    }()
}
