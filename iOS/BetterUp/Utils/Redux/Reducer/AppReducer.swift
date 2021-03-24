//
//  AppReducer.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Foundation

class AppReducer {
    class func reduce(state: inout AppState,
                      action: AppAction) {
        switch(action) {
        case let .feedListFlow(action):
            feedListReducer(state: &state.feedFlowState,
                            action: action)
        }
    }
}
