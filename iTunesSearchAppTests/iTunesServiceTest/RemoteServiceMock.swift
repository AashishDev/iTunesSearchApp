//
//  RemoteServiceMock.swift
//  iTunesSearchAppTests
//
//  Created by Aashish Tyagi on 9/25/22.
//

import XCTest
@testable import iTunesSearchApp


struct RemoteServiceMock:RemoteServiceProtocol {
    
    var responseModel:iTunesSearchResponse?
    func execute(request: URLRequest, completion: @escaping ((Result<Data, Error>) -> Void)) {
        do {
          let data = try JSONEncoder().encode(responseModel)
          completion(.success(data))
        }
        catch {
              completion(.failure(error))
        }
    }
}
