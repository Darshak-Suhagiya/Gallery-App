//
//  SigninVCViewController.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import UIKit
import GoogleSignIn
import PKHUD

class SigninVC: UIViewController {

    var viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        viewModel.signInWithGoogle(vc: self)
    }
}
