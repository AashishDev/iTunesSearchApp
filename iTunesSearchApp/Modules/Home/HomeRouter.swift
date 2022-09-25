//
//  HomeRouter.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation
import UIKit
// Object
// Entry point

protocol HomeRouterProtocol: AnyObject {
    static func createHomeListModule(homeListRef: HomeViewController)
    
     func pushToMediaTypeModule(from view: HomeViewController)
     func pushToDetailModule(searchText:String, selectedTypes:[String], from vc:HomeViewController)
}

class HomeRouter:HomeRouterProtocol {
    static func createHomeListModule(homeListRef: HomeViewController) {
        let presenter = HomePresenter()
        
        homeListRef.presenter = presenter
        homeListRef.presenter?.router = HomeRouter()
        homeListRef.presenter?.view = homeListRef
        homeListRef.presenter?.interactor = HomeInteractor()
        homeListRef.presenter?.interactor?.presenter = presenter
    }
    
    func pushToMediaTypeModule(from view: HomeViewController) {
        let stroyBoard = UIStoryboard(name: "Main", bundle: .main)
        let mediaTypeVC = stroyBoard.instantiateViewController(withIdentifier: "MediaTypeViewController") as! MediaTypeViewController
        
        MediaTypeRouter.createMediaTypeListModule(mediaTypeListRef: mediaTypeVC)
        mediaTypeVC.delegate = view
        view.show(mediaTypeVC, sender: view)
    }
    
    func pushToDetailModule(searchText: String, selectedTypes: [String], from vc: HomeViewController) {
        let stroyBoard = UIStoryboard(name: "Main", bundle: .main)
        let detailVc = stroyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        DetailRouter.createDetailListModule(detailListRef: detailVc)
        detailVc.entity = selectedTypes
        detailVc.searchText = searchText
        vc.show(detailVc, sender: vc)
    }
}

