//
//  HomePresenter.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation
import UIKit
// Object
// Protocol
// ref to interactor, router, view

protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorProtocol? {get set}
    var view: HomeListViewProtocol? {get set}
    var router: HomeRouterProtocol? {get set}
    
    func viewDidLoad()
    func showMediaTypeSelection(from view: HomeViewController)
    func submitDetailForSearching(searchText:String, selectedTypes: [String], from view:HomeViewController)
}

class HomePresenter: HomePresenterProtocol {
    var router: HomeRouterProtocol?
    weak var view: HomeListViewProtocol?
    var interactor: HomeInteractorProtocol?

    func viewDidLoad() {}
    
    func showMediaTypeSelection(from view: HomeViewController) {
        router?.pushToMediaTypeModule(from: view)
    }
    
    //TODO: Refactoring required here
    func submitDetailForSearching(searchText: String, selectedTypes: [String], from view:HomeViewController) {
        guard let validationResult = interactor?.valdiate(searchText: searchText, mediaTypes: selectedTypes) else { return }
        
        if validationResult.success {
            router?.pushToDetailModule(searchText: searchText, selectedTypes: selectedTypes, from:view)
        }
        else {
            view.showAlertWith(message:validationResult.errorMesage, buttons: ["Okay"], completion: nil)
        }
    }
}


