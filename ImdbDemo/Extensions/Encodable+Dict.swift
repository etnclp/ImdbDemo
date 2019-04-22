//
//  Encodable+Dict.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 23.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
