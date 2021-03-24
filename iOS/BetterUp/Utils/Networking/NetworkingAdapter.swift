//
//  NetworkingAdapter.swift
//  Medly
//
//  Created by Vlad Z. on 3/23/21.
//

import Foundation
import Combine

public struct AdapterConfig {
    public var base: String
    public var name: String

    public init(base: String,
                name: String) {
        self.base = base
        self.name = name
    }
}

public protocol NetworkingAdapter {
    var settings: AdapterConfig { get }
}

public extension NetworkingAdapter {
    /// Generate component for the API request
    func generateRequestComponents(_ request: RequestConfig? = nil) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = settings.base

        var pathItems: [String] = []

        pathItems.append(contentsOf: [settings.name])
        if let path = request?.path { pathItems.append(path) }

        let cleanedPath = pathItems
            .filter { !$0.isEmpty }
            .joined(separator: "/")

        components.path = "/\(cleanedPath)"

        return components
    }

    func request(_ request: RequestConfig) -> AnyPublisher<Data, Error> {
        let components = generateRequestComponents(request)

        let apiMan = APIManager.shared
        return apiMan.request(for: components,
                              config: request)
    }
}
