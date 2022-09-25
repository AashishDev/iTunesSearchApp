//
//  Constant.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation

enum APIConstant {
    static let BaseUrl = "https://itunes.apple.com/"
    static let Search = "search"
}

enum AlertMessage {
   static let EmptySearchText = "Please enter your content to search"
   static let EmptyMediaType = "Please select atleast one Media type"
   static let NoRecordFound = "No Record found, try with other media type"
}

