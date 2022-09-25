//
//  MediaTypeInteractor.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

protocol MediaTypeInteractorProtocol: AnyObject {
    var presenter: MediaTypePresenterProtocol? {get set}
}

class MediaTypeInteractor:MediaTypeInteractorProtocol {
    var presenter: MediaTypePresenterProtocol?
}
