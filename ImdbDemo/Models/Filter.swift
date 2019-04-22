//
//  Filter.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct Filter: Encodable {
    let title: String
    let content: ContentType?
    let year: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "s"
        case content = "type"
        case year = "y"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(year, forKey: .year)
    }
}

enum ContentType: String, Codable {
    case all = ""
    case movie = "movie"
    case series = "series"
    case episode = "episode"
    case game = "game"
    
    static let allValues = [all, movie, series, episode]
    
    var title: String {
        switch self {
        case .all: return "All"
        case .movie: return "Movie"
        case .series: return "Series"
        case .episode: return "Episode"
        case .game: return "Game"
        }
    }
}
