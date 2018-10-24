//
//  LoginViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class LoginViewModel: SNBaseViewModel {

   

}

extension LoginViewModel {
    
    
    func loginSuccess(model: LoginApiModel? = nil) {
        
//        Singleton.shared.token = model.token
        Singleton.shared.token = "TrfDX8cCPSsK6jCt_3mlG4NUDene1KZewSRbHDNm9RY"
        Singleton.shared.refreshToken()
        
        let window = UIApplication.shared.keyWindow
        
        let rootVC = SNMainTabBarController.shared
        rootVC.modalTransitionStyle = .crossDissolve
        
        let animation = {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window?.rootViewController = SNMainTabBarController.shared
            UIView.setAnimationsEnabled(oldState)
        }
        
        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: animation, completion: nil)
        
    }
    
}
