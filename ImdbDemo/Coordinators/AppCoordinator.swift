//
//  AppCoordinator.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case filter
    case movies(filter: Filter)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    private var home: Presentable?
    
    init() {
        super.init(initialRoute: .filter)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .filter:
            let filter = FilterViewController()
            filter.bind(to: FilterViewModelImpl(router: anyRouter))
            return .push(filter)
        case .movies(let filter):
            let movies = MoviesViewController()
            movies.bind(to: MoviesViewModelImpl(router: anyRouter, filter: filter))
            return .push(movies)
        }
    }
    
}
