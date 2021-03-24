//
//  Store.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import SwiftUI
import Combine

typealias Dispatcher<Action> = (Action) -> Void
typealias AppStore = Store<AppState, AppAction>
typealias Reducer<State, Action> = (inout State, Action) -> Void
typealias Middleware<State, Action> = (State, Action, @escaping Dispatcher<Action>) -> Void

typealias CommandWith<T> = (T) -> ()

class Store<State, Action>: ObservableObject {
    @Published private (set) var state: State

    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]

    private let queue = DispatchQueue(label: "Store queue", qos: .userInitiated)

    // MARK:- Initializers
    init(initial state: State,
         middlewares: [Middleware<State, Action>],
         reducer: @escaping Reducer<State, Action>) {
        self.state = state
        self.middlewares = middlewares
        self.reducer = reducer
    }

    func dispatch(_ action: Action) {
        // If calling thread is main thread then updating state instantly will result better UI
        if Thread.isMainThread {
            reducer(&state, action)
        } else {
            DispatchQueue.main.async {
                self.reducer(&self.state, action)
            }
        }

        queue.async {
            self.middlewares.forEach { [weak self] middleware in
                guard let self = self else { return }
                middleware(self.state, action, self.dispatch)
            }
        }
    }

    func bind<T>(_ action: @escaping (T) -> Action) -> CommandWith<T> {
        return { value in
            self.dispatch(action(value))
        }
    }
}
