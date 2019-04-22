//
//  FilterViewModel.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Action
import RxSwift
import RxCocoa

protocol FilterViewModel {
    /**
     Returns a search title.
     */
    var titleFilter: BehaviorRelay<String?> { get }
    /**
     Returns a search type.
     */
    var typeFilter: BehaviorRelay<ContentType?> { get }
    /**
     Returns a search year.
     */
    var yearFilter: BehaviorRelay<String?> { get }
    /**
     Returns an error if has.
     */
    var error: PublishSubject<FilterError> { get }
    /**
     The trigger must be called when asked to search.
     */
    var searchButtonTrigger: InputSubject<Void> { get }
}
