//
//  ApiTests.swift
//  ImdbDemoTests
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Quick
import Nimble
import Moya
@testable import ImdbDemo

class ApiTests: QuickSpec {
    
    override func spec() {
        describe("Provider test json") {
            var provider: MoyaProvider<ImdbAPI>!
            
            beforeEach {
                provider = MoyaProvider<ImdbAPI>(endpointClosure: self.customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
            }
            
            it("emits a Response object") {
                var called = false
                
                _ = provider.rx.request(.search(searchText: ""))
                    .subscribe { event in
                        switch event {
                        case .success(let response):
                            log.debug(response)
                            called = true
                        case .error(let error):
                            fail("errored: \(error)")
                        }
                }
                
                expect(called).to(beTrue())
            }
        }
    }
    
    func customEndpointClosure(_ target: ImdbAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
}

extension ImdbAPI {
    var testSampleData: Data {
        switch self {
        case .search:
            let url = Bundle(for: ApiTests.self).url(forResource: "SearchResult1", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
}
