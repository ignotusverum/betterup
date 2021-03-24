//
//  JSONDecoder.swift
//  BetterUp
//
//  Created by Vlad Z. on 3/16/21.
//

import Foundation

extension JSONDecoder {
    static var iso8601SnakeCaseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
