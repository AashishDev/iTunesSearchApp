//
//  HomeInteractor.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation
// object
// protocol
// ref to presenter

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? {get set}
    
    func valdiate(searchText:String, mediaTypes:[String]) -> ValidationResult
}

class HomeInteractor:HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    func valdiate(searchText:String, mediaTypes:[String]) -> ValidationResult {
        Validation.validate(query: searchText, mediaType: mediaTypes)
    }
}


