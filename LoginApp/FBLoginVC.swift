//
//  FBLoginVC.swift
//  LoginApp
//
//  Created by Lan Ran on 2022/3/22.
//

import UIKit
import FacebookCore
import FacebookLogin

class FBLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let accessToken = AccessToken.current {//存取使用者資訊
            Profile.loadCurrentProfile(completion: {(profile,error) in
                if let profile = profile {
                    //這邊要求的使用者資訊
                    
                    print(profile.name)
                    print(profile.email)
                    print(profile.imageURL(forMode: .square, size:CGSize(width: 300, height: 300) ))
                }
                
            })
            
        }
    }
    

    @IBAction func login(){
        
        let messager = LoginManager()
        messager.logIn(permissions: [.publicProfile,.email]){(result) in
            if case LoginResult.success(granted: _, declined: _, token: _) = result{
                print("login OK")
            }
            else{
                print("login fail")
            }
        }
        
    }

}
