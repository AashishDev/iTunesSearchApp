//
//  ViewController+Extension.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import UIKit

extension UIViewController {
    
    func showAlertWith(title:String = "Alert", message:String?, style: UIAlertController.Style = .alert, buttons:[String], completion:((Bool,Int)->Void)?) -> Void {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: style)
        for (index,title) in buttons.enumerated() {
            let action = UIAlertAction.init(title: title, style: UIAlertAction.Style.default) { (action) in
                completion?(true,index)
            }
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
