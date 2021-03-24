//
//  StoreProvider.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import SwiftUI

struct StoreProvider<Content: View>: View {
    @EnvironmentObject var store: AppStore
    let content: () -> Content

    var body: some View {
        content()
    }
}
