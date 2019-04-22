//
//  MoviesViewModelImpl.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import XCoordinator

class MoviesViewModelImpl: MoviesViewModel {
    
    // MARK: - Properties
    
    private let router: AnyRouter<AppRoute>
    private let filter: Filter
    
    private let provider: MoyaProvider<ImdbAPI> = .init()
    private var disposeBag: DisposeBag = .init()
    
    private var currentPage = 0
    private var lastPage = 2
    private var limit = 10
    
    private var nextPage: Int? {
        guard (currentPage < lastPage) else { return nil }
        return currentPage + 1
    }
    
    var elements: BehaviorRelay<[Search]> = .init(value: [])
    var error: PublishSubject<Swift.Error> = .init()
    
    var nextPageTrigger: PublishSubject<Void> = .init()
    
    // MARK: - Initialization
    
    init(router: AnyRouter<AppRoute>, filter: Filter) {
        self.router = router
        self.filter = filter
        
        nextPageTrigger
            .flatMap { _ -> Observable<SearchResult> in
                guard let next = self.nextPage else {
                    self.disposeBag = DisposeBag()
                    return .empty()
                }
                
                return self.getSearchResult(page: next)
                    .do(onError: { [weak self] error in
                        self?.error.onNext(error)
                    })
                    .catchError { (error) -> Observable<SearchResult> in
                        self.error.onNext(error)
                        return .empty()
                }
            }
            .scan([]) { (previous, current) -> [Search] in
                return previous + current.search
            }
            .bind(to: elements)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Action
    
    private func getSearchResult(page: Int = 1) -> Observable<SearchResult> {
        return provider.rx.request(.search(filter: self.filter, page: page))
            .map(SearchResult.self)
            .do(onSuccess: { [unowned self] result in
                self.currentPage += 1
                if let total = Int(result.totalResults) {
                    let lastPage = Int((CGFloat(total) / CGFloat(self.limit)).rounded())
                    self.lastPage = lastPage
                }
            })
            .asObservable()
        
    }
    
}
