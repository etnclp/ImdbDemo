//
//  Filter.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct Filter {
    let title: String
    let content: ContentType
    let year: Int
}

enum ContentType: String {
    case all = ""
    case movie = "movie"
    case series = "series"
    case episode = "episode"
}
