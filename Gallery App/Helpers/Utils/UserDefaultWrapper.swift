//
//  UserDefaultWrapper.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import Foundation

@propertyWrapper
public struct UserDefaultWrapper<T> {
    var key: String
    var defaultT: T!
    public var wrappedValue: T! {
        get { (UserDefaults.standard.object(forKey: key) as? T) ?? defaultT }
        nonmutating set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }

    init(_ key: String, _ defaultT: T! = nil) {
        self.key = key
        self.defaultT = defaultT
    }
}
