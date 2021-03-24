//
//  Connector.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import SwiftUI
import Combine

protocol Connector: View {
    associatedtype Content: View
    func map() -> Content
}

extension Connector {
    var body: some View {
        Connected<Content>(map: map)
    }
}

fileprivate struct Connected<V: View>: View {
    @EnvironmentObject var store: AppStore

    let map: () -> V
    var body: V {
        map()
    }
}

