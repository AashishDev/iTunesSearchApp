//
//  Endpoint.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//
import Foundation

enum HTTPMethods:String {
    case GET
    case POST
}

public enum EndPoint {
    case Search(query:String,entity:String)
    
    var requestType:String {
        switch self {
        case  .Search :
            return HTTPMethods.GET.rawValue
        }
    }
    
    var path:String {
        switch self {
        case .Search(let query,let entity):
            return APIConstant.BaseUrl + APIConstant.Search + "?term=\(query)&entity=\(entity)"
        }
    }
}
