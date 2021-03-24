//
//  RootView.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import SwiftUI

struct RootView: View {
    let store: AppStore

    init(store: AppStore) {
        self.store = store
    }

    var body: some View {
        StoreProvider() {
            FeedListViewConnector()
        }
        .environmentObject(store)
    }
}
