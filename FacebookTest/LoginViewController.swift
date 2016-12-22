//
//  ViewController.swift
//  FacebookTest
//
//  Created by Mobile Developer on 12/7/16.
//  Copyright © 2016 PlooseTech. All rights reserved.
//

import UIKit
import Foundation
import GoogleSignIn
import Firebase




class LoginViewController: UIViewController {
   
    @IBAction func FBAction(_ sender: UIButton) {
        FacebookLoginManager.loginWithFB(self, onSuccess: { (fbToken) in
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: fbToken.authenticationToken)
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("\(error)")
                    return
                }
                print("Succesfully Login With FBToken")
            })
        }) { (error) in
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = FIRAuth.auth()?.currentUser
        print("\(user?.email)")
        signOut()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpGIDSignIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: Handle GoogleSignIn
    
    
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func setUpGIDSignIn() {
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signInSilently()
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        FirebaseManager.authenticateWithGoogle(user: user)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func signOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("FIRUser Successfully signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

}

