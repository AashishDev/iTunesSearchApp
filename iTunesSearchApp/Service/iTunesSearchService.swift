//
//  iTunesSearchService.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//
import Foundation

struct SearchResultModel:Codable {
    let id:Int
    let name:String
    let assetPath:String
    
    private enum CodingKeys : String, CodingKey {
        case id = "artistId"
        case name = "collectionName"
        case assetPath = "artworkUrl100"
    }
}

struct iTunesSearchResponse:Codable {
    let items:[SearchResultModel]
    
    private enum CodingKeys : String, CodingKey {
        case items = "results"
    }
}

protocol iTunesSearchServiceProtocol {
    func loadItems(query:String,entity:String) async throws -> iTunesSearchResponse
}

struct iTunesSearchService:iTunesSearchServiceProtocol {
    private let apiManager:APIServiceProtocol
    init(apiManager:APIServiceProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func loadItems(query:String,entity:String) async throws -> iTunesSearchResponse {
        
        return try await withCheckedThrowingContinuation { continuation in
            self.apiManager.execute(responseType: iTunesSearchResponse.self, endpoint: .Search(query: query, entity: entity)) { result in
                continuation.resume(with: result)
            }
        }
    }
}
