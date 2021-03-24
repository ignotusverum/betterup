//
//  FeedListState.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Foundation

enum FeedListState {
    case initial
    case feedFetched([Article])

    init() { self = .initial }
}
