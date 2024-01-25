//
//  HomeVM.swift
//  Gallery App
//
//  Created by Amul Patel on 26/01/24.
//

import Foundation
import GoogleSignIn


class HomeVM {
    
    func signInWithGoogle(vc: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            let emailAddress = user.profile?.email
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            // update user default to store current user's data
            UserDefaults.GA.isUserLogin = true
            UserDefaults.GA.email = emailAddress
            UserDefaults.GA.userName = (givenName ?? "") + " " + (familyName ?? "")
            UserDefaults.GA.profileURL = profilePicUrl?.absoluteString
            
            // navigate to gallery controller
            let galleryVC = GalleryVC(nibName: "GalleryVC", bundle: nil)
            changeWindow(from: vc, to: galleryVC)
        }
    }
    
    func signOut(vc: UIViewController) {
        GIDSignIn.sharedInstance.signOut()
        // remove current user's images from local database
        CoreDataManager.shared.clearAllImages()
        // relese uesrdefaults
        UserDefaults.GA.removeAllData()
        let SignInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
        
        changeWindow(from: vc, to: SignInVC)
    }
}
