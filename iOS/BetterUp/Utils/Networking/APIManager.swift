//
//  NetworkingAdapter.swift
//  Medly
//
//  Created by Vlad Z. on 3/23/21.
//

import Combine
import Foundation

public final class APIManager {
    public static let shared = APIManager(session: URLSession.shared)

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func request(for component: URLComponents,
                        config: RequestConfig) -> AnyPublisher<Data, Error> {
        guard let path = component.url?.absoluteString,
              let url = URL(string: path) else {
            return Fail(error: ApplicationError.apiError(type: .commonError)).eraseToAnyPublisher()
        }

        let request = self.prepareRequest(method: config.method,
                                          url: url)

        return session
            .dataTaskPublisher(for: request)
            .validate(using: { data, response in
                guard let response = response as? HTTPURLResponse,
                      200 ..< 300 ~= response.statusCode else {
                    throw ApplicationError.apiError(type: .responseError(error: String(data: data,
                                                                                       encoding: .utf8)))
                }
            })
            .map(\.data)
            .eraseToAnyPublisher()
    }

    private func prepareRequest(method: HTTPMethod,
                                url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}

extension Publisher {
    func validate(
        using validator: @escaping (Output) throws -> Void
    ) -> Publishers.TryMap<Self, Output> {
        tryMap { output in
            try validator(output)
            return output
        }
    }
}
