//
//  AppleLoginVCViewController.swift
//  LoginApp
//
//  Created by Lan Ran on 2022/3/22.
//

import UIKit
import AuthenticationServices

class AppleLoginVCViewController: UIViewController{
    

    @IBOutlet weak var appleLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLoginBtn()
    }
    
    
    func setUpLoginBtn(){
        let authorizationAppleButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton()
        authorizationAppleButton.addTarget(self, action: #selector(pressBtnLoginApple), for: .touchUpInside)
        authorizationAppleButton.frame = appleLogin.bounds
        self.appleLogin.addSubview(authorizationAppleButton)
    }
    
    @objc func pressBtnLoginApple(){
        
        let authorizationAppleIDRequest:ASAuthorizationAppleIDRequest = ASAuthorizationAppleIDProvider().createRequest()
        authorizationAppleIDRequest.requestedScopes = [.fullName,.email] //建立使用者資訊請求
        
        let controller : ASAuthorizationController  = ASAuthorizationController(authorizationRequests: [authorizationAppleIDRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
        
    }

   

}


extension AppleLoginVCViewController:ASAuthorizationControllerDelegate{
    
    //授權成功
    //能獲得的資料
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("user : \(appleIDCredential.user) ")
            print("fullName :  \(String(describing: appleIDCredential.fullName ))")
            print("Email :  \(String(describing: appleIDCredential.email ))")
            print("status :  \(String(describing: appleIDCredential.realUserStatus ))")
        }
    }
    
    
    // 授權失敗
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        switch (error){
        case ASAuthorizationError.canceled:break
        case  ASAuthorizationError.failed:break
        case ASAuthorizationError.invalidResponse:break
        case ASAuthorizationError.notHandled:break
        case ASAuthorizationError.unknown:break
        default:break
        }
        print("error : \(error.localizedDescription)")
    }
    
}


extension AppleLoginVCViewController:ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}


//檢查用戶登入登出狀況

extension AppleLoginVCViewController{
    
    private func checkCredentialState(withUserID userID:String){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID){ (credentialState,error) in
            switch credentialState{
            case .authorized:break //已登入
            case .revoked:break //已登出
            case .notFound: break//無此用戶
            default:break
            }
            
        }
    }
}

