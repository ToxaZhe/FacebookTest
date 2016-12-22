//
//  FacebookLoginManager.swift
//  FacebookTest
//
//  Created by user on 12/15/16.
//  Copyright © 2016 PlooseTech. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore


struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        let rawResponse: Any?
        let email: String?
        let name: String?
        init(rawResponse: Any?) {
            
            self.rawResponse = rawResponse
            let dict = rawResponse as? [String: Any]
            self.email = dict?["email"] as? String
            self.name = dict?["name"] as? String
        }
    }
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, email"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}


class FacebookLoginManager {
    
    
    static func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let result = SDKApplicationDelegate.shared.application(application, open: url, options: [.sourceApplication : options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, .annotation : options[UIApplicationOpenURLOptionsKey.annotation] as Any])
        return result
    }
    
    
    static func getUserFBProfile(_ fbAuthenticationToken: String) {
        let connection = GraphRequestConnection()
        connection.add(MyProfileRequest()) { (httpResponse, result) in
            switch result {
            case .success(let response):
              RequestManager.loadRequestWithResponse(response.email, fbAuthenticationToken: fbAuthenticationToken)
                
            case .failed(let error):
                print("Custom Graph Request Failed: \(error)")
            }
        }
        connection.start()

    }
    
    static func loginWithFB(_ controller: UIViewController, onSuccess: @escaping (AccessToken) -> (), onError: @escaping (Error) -> ()) {
        let loginManager: LoginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: controller) { loginResult in
            switch loginResult {
            case .failed(let error):
                onError(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("\(accessToken)---> \(declinedPermissions), \(grantedPermissions)")
                onSuccess(accessToken)
//                FacebookLoginManager.getUserFBProfile(accessToken.authenticationToken)
                
                
            }
        }

    }
    
}
