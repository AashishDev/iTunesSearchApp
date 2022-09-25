//
//  MediaPresenter.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//
import UIKit


protocol MediaTypePresenterProtocol:AnyObject {
    var interactor: MediaTypeInteractor? {get set}
    var view: MediaTypeViewProtocol? {get set}
    var router: MediaTypeRouterProtocol? {get set}
    
    func doneButtonTapped(from view: MediaTypeViewController)
}


class MediaTypePresenter: MediaTypePresenterProtocol {
    var router: MediaTypeRouterProtocol?
    weak var view: MediaTypeViewProtocol?
    var interactor: MediaTypeInteractor?
    
    func doneButtonTapped(from view: MediaTypeViewController) {
        router?.backToPreviousScreen(from: view)
    }
}

