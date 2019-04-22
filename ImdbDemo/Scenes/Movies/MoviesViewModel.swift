//
//  MoviesViewModel.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MoviesViewModel {
    /**
     Returns a list of search.
     */
    var elements: BehaviorRelay<[Search]> { get }
    /**
     Returns an error if has.
     */
    var error: PublishSubject<Swift.Error> { get }
    /**
     When NextPageTrigger is called, adds the new data to the elements list by request to the API.
     */
    var nextPageTrigger: PublishSubject<Void> { get }
}
