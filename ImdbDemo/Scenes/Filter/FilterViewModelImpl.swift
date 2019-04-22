//
//  FilterViewModelImpl.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Action
import RxSwift
import RxCocoa
import XCoordinator

class FilterViewModelImpl: FilterViewModel {
    
    // MARK: - Properties
    
    private let router: AnyRouter<AppRoute>
    
    var titleFilter: BehaviorRelay<String?> = .init(value: nil)
    var typeFilter: BehaviorRelay<ContentType?> = .init(value: nil)
    var yearFilter: BehaviorRelay<String?> = .init(value: nil)
    var error: PublishSubject<FilterError> = .init()
    lazy var searchButtonTrigger: InputSubject<Void> = searchButtonAction.inputs
    
    private lazy var searchButtonAction = CocoaAction { [unowned self] (_) in
        guard let title = self.titleFilter.value, title.count > 2 else {
            self.error.onNext(.validation(.title))
            return .empty()
        }
        
        let filter = Filter(title: title, content: self.typeFilter.value, year: self.yearFilter.value)
        return self.router.rx.trigger(.movies(filter: filter))
    }
    
    // MARK: - Initialization
    
    init(router: AnyRouter<AppRoute>) {
        self.router = router
    }
    
}

enum FilterError: Error {
    case validation(FilterValidationError)
}

enum FilterValidationError {
    case title, type, year
    
    var errorMessage: String {
        switch self {
        case .title: return "En az 3 harf olacak şekilde başlık bilgisi giriniz."
        case .type: return ""
        case .year: return ""
        }
    }
}
