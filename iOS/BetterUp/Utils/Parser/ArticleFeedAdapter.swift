//
//  ArticleFeedAdapter.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Combine
import Foundation

class ArticleFeedAdapter {
    class func fetch()-> AnyPublisher<ArticlesFeed, Error> {
        Future<ArticlesFeed, Error> { promise in
            let jsonParser = JSONDecoder.iso8601SnakeCaseDecoder

            let bundle = Bundle.main
            let path = bundle.path(forResource: "articles",
                                   ofType: "json")!

            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let articlesFeed = try jsonParser.decode(ArticlesFeed.self,
                                                         from: data)
                promise(.success(articlesFeed))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
