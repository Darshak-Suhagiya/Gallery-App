//
//  Config.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import Foundation
import UIKit

//MARK: alert the user
func alertTheUser(_ vc: UIViewController,string: String) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: "Alert!", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true, completion: nil)
    }
}

//MARK: Change Window with navigation controller
func changeWindow(from: UIViewController, to: UIViewController) {
    
    let rootNC = UINavigationController(rootViewController: to)
    rootNC.isNavigationBarHidden = true
    
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = .push
    transition.isRemovedOnCompletion = true
    transition.subtype = .fromRight
    from.view.window?.layer.add(transition, forKey: kCATransition)
    
    from.view.window!.rootViewController = rootNC
}
