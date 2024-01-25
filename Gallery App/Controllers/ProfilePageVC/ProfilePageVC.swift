//
//  ProfilePageVC.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import UIKit
import GoogleSignIn
import SDWebImage
import UIKit

class ProfilePageVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the image with SDWebImage
        let imageURL = URL(string: UserDefaults.GA.profileURL ?? "")
        profileImageView.sd_setImage(with: imageURL)
        nameLabel.text = UserDefaults.GA.userName
        emailLabel.text = UserDefaults.GA.email
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        viewModel.signOut(vc: self)
    }
}
