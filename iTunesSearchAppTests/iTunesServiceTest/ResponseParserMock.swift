//
//  ResponseParserMock.swift
//  iTunesSearchAppTests
//
//  Created by Aashish Tyagi on 9/25/22.
//

import XCTest
@testable import iTunesSearchApp

struct ResponseParserMock:ResponseParserProtocol {
   
    func parse<T>(type: T.Type, data: Data, completion: (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        completion(.failure(APIError.unableToParsed))
    }
}
