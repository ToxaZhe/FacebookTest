//
//  FirebaseManager.swift
//  FacebookTest
//
//  Created by Mobile Developer on 12/20/16.
//  Copyright © 2016 PlooseTech. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn


class FirebaseManager {
    
    static func authenticateWithGoogle(user: GIDGoogleUser) {
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print("successfully signed-in with Google")
            if let error = error {
                print("\(error)")
                return
            }
        }

    }
}
