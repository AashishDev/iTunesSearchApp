//
//  DetailInteractor.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? {get set}
    var service:iTunesSearchServiceProtocol? { get set }
    
    func searchItemForSelectedMediaType(searchText:String,MediaTypes:[String]) async throws -> [[SearchResultModel]]
}

class DetailInteractor:DetailInteractorProtocol {
    var service: iTunesSearchServiceProtocol? =  iTunesSearchService()
    var presenter: DetailPresenterProtocol?
    let urlDownloadGroup = DispatchGroup()

    
    func searchItemForSelectedMediaType(searchText: String, MediaTypes: [String]) async throws -> [[SearchResultModel]] {
        
        var searchResult = [[SearchResultModel]]()
        
        return await withTaskGroup(of: [SearchResultModel].self) { group in
            for name in MediaTypes {
                group.addTask {
                    let capital = await self.searchItunesProducts(searchText: searchText, entityName: name)
                    return capital ?? []
                }
            }
            
            for await currentGroup in group {
                searchResult.append(currentGroup)
            }
            
            return searchResult
        }
        
       /*
        try await MediaTypes.asyncMap { id in
            try await searchItunesProducts(searchText: searchText, entityName: id)
        } as! [[SearchResultModel]]*/
        
    }
    
    private func searchItunesProducts(searchText:String, entityName:String) async  -> [SearchResultModel]? {
        do {
            let response = try await self.service?.loadItems(query: searchText, entity: entityName)
            return response?.items
        }
        catch {
            return []
        }
    }
    
}
