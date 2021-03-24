//
//  Article.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Foundation

struct Article: Codable, Hashable {
    let id: Int
    let title: String
    let createdAt: Date
    let source: String
    let description: String
    var favorite: Bool
    let heroImage: URL
    let link: URL
}

struct ArticlesFeed: Codable {
    let articles: [Article]
}
