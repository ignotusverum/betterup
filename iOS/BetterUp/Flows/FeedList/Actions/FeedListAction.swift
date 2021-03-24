//
//  FeedListAction.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Foundation

enum FeedListAction {
    case openLink(url: URL)
    case fetched([Article])
    case reload(filterByFaves: Bool)
    
    case error(Error)
}
