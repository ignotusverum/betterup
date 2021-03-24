//
//  FeedListReducer.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import UIKit
import Foundation

func feedListReducer(state: inout FeedListState,
                     action: FeedListAction) {
    switch action {
    case .fetched(let feed):
        state = .feedFetched(feed)
    case let .openLink(link):
        guard UIApplication.shared.canOpenURL(link) else { return }
        UIApplication.shared.open(link,
                                  options: [:],
                                  completionHandler: nil)

    default: break
    }
}
