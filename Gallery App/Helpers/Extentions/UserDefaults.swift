//
//  UserDefaults.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import Foundation

extension UserDefaults {
    // property wrappers for userdefault
    struct GA {
        private init() { }
        
        @UserDefaultWrapper("UserLogin",false)
        static var isUserLogin:Bool!
        
        @UserDefaultWrapper("UserEmail",nil)
        static var email:String?
        
        @UserDefaultWrapper("UserName",nil)
        static var userName:String?
        
        @UserDefaultWrapper("UserProfileURL",nil)
        static var profileURL:String?
        
        static func removeAllData() {
            isUserLogin = false
            email = nil
            userName = nil
            profileURL = nil
        }
    }
}
