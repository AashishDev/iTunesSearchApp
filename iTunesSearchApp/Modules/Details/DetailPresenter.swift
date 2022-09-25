//
//  DetailPresenter.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var interactor: DetailInteractorProtocol? {get set}
    var view: DetailViewProtocol? {get set}
    var router: DetailRouterProtocol? {get set}
    
    func fetchItunesItem(searchText:String, mediaTypes:[String])  async -> [[SearchResultModel]]?
}

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?

    func fetchItunesItem(searchText: String, mediaTypes: [String]) async -> [[SearchResultModel]]? {
        
        let result = try? await interactor?.searchItemForSelectedMediaType(searchText: searchText, MediaTypes: mediaTypes)
        
        let response =  result?.filter({ $0.count > 0 })
        return response
    }
    
}
