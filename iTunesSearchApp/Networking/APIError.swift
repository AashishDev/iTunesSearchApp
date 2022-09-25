//
//  APIError.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

public enum APIError: Error {
    case InValidURL
    case serverError
    case unableToParsed
}

extension APIError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .InValidURL:
            return "Invalid url"
        case .serverError:
            return "There is a problem with the server. Please try again."
        case .unableToParsed:
            return "Data is not in correct format."
        }
    }
}
