//
//  ServiceManager.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import UIKit
import Foundation

class ServiceManager: NSObject {
    
    static let shared: ServiceManager = ServiceManager()
    
    //MARK:- GET Service Calling
    public func apiCall(apiURL: String, parameters: [String: String], headers: [String:String], completion: @escaping (_ data:Data?, _ error:String?) -> Void) {

        let Url = String(format: apiURL)
        guard let serviceUrl = URL(string: Url) else {
            completion(nil,"Invalid URL")
            return
        }

        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"

        var components = URLComponents(url: serviceUrl, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            request.url = components?.url

        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil,error.localizedDescription)
                return
            }
            if let data = data {
                completion(data,nil)
            }
        }.resume()
    }
}


