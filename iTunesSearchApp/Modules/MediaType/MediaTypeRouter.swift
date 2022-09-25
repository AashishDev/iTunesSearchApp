//
//  MediaTypeRouter.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import UIKit


protocol MediaTypeRouterProtocol: AnyObject {
    static func createMediaTypeListModule(mediaTypeListRef: MediaTypeViewController)
    func backToPreviousScreen(from view:MediaTypeViewController)
}

class MediaTypeRouter:MediaTypeRouterProtocol {
    
    static func createMediaTypeListModule(mediaTypeListRef: MediaTypeViewController) {
        let presenter = MediaTypePresenter()
        
        mediaTypeListRef.presenter = presenter
        mediaTypeListRef.presenter?.router = MediaTypeRouter()
        mediaTypeListRef.presenter?.view = mediaTypeListRef
        mediaTypeListRef.presenter?.interactor = MediaTypeInteractor()
        mediaTypeListRef.presenter?.interactor?.presenter = presenter
    }
    
    func backToPreviousScreen(from view:MediaTypeViewController) {
        view.navigationController?.popToRootViewController(animated: true)
    }
}


