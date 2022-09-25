//
//  DetailRouter.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    static func createDetailListModule(detailListRef: DetailViewController)
    func backToPreviousScreen(from view:DetailViewController)
}

class DetailRouter:DetailRouterProtocol {
    
    static func createDetailListModule(detailListRef: DetailViewController) {
        let presenter = DetailPresenter()
        
        detailListRef.presenter = presenter
        detailListRef.presenter?.router = DetailRouter()
        detailListRef.presenter?.view = detailListRef
        detailListRef.presenter?.interactor = DetailInteractor()
        detailListRef.presenter?.interactor?.presenter = presenter
    }
    
    func backToPreviousScreen(from view:DetailViewController) {
        view.navigationController?.popToRootViewController(animated: true)
    }
}
