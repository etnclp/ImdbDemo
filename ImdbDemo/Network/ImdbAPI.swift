//
//  ImdbAPI.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Moya

enum ImdbAPI {
    case search
}

extension ImdbAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://www.omdbapi.com")!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/"
        }
    }
    
    var method: Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        if method == .post {
            return .requestParameters(parameters: parameters, encoding: URLEncoding(destination: .queryString))
        } else {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    
}
