//
//  GoogleLoginManager.swift
//  FacebookTest
//
//  Created by Mobile Developer on 12/16/16.
//  Copyright © 2016 PlooseTech. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn



class GoogleManager {

    static func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let result = GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        return result
    }
}
