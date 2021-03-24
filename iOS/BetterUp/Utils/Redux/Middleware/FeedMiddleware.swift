//
//  FeedMiddleware.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Foundation
import Combine

class FeedMiddleware: MiddlewareProcessing {
    class func handler() -> Middleware<AppState, AppAction> {
        return { state, action, dispatch in
            switch action {
            case let .feedListFlow(action):
                switch action {
                case let .reload(filterByFaves):
                    fetchFeed(dispatch: dispatch,
                              filterByFaves: filterByFaves)
                default: break
                }
            }
        }
    }

    private class func fetchFeed(dispatch: @escaping Dispatcher<AppAction>,
                                 filterByFaves: Bool) {
        ArticleFeedAdapter
            .fetch()
            .sink{ completion in
                switch completion {
                case .failure(let error):
                    dispatch(.feedListFlow(action: .error(error)))
                default: break
                }
            } receiveValue: { feed in
                var filterResponse: [Article] = feed.articles
                if filterByFaves {
                    filterResponse = filterResponse.filter { $0.favorite }
                }

                dispatch(.feedListFlow(action: .fetched(filterResponse)))
            }
            .store(in: &MiddlewareFactory.cancellables)
    }
}
