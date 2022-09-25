//
//  Validation.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import Foundation
import UIKit

struct ValidationResult {
    let success:Bool
    let errorMesage:String?
}

struct Validation {
   static func validate(query:String,mediaType:[String]) -> ValidationResult {
       if query.isEmpty {
           return ValidationResult(success: false, errorMesage: AlertMessage.EmptySearchText)
        }
        else if mediaType.count == 0 {
            return ValidationResult(success: false, errorMesage: AlertMessage.EmptyMediaType)
        }
        return ValidationResult(success: true, errorMesage: nil)
    }
}
