//
//  LoginViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import RxCocoa

class LoginViewModel: SNBaseViewModel {

   let usernameRep = BehaviorRelay(value: "")
    let passwordRep = BehaviorRelay(value: "")
}

extension LoginViewModel {
    
    func login() {
        
        let username = usernameRep.value
        let password = passwordRep.value
        
        APIRequest(requestType: APIExp.login(username: username, password: password), modelType: LoginApiModel.self).subscribe(onNext: { (result) in
            switch result {
            case .success(let model):
                self.loginSuccess(model: model)
            case let .fail(code, msg):
                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
            default:
                break
            }
        }, onError: { (e) in
            self.netErrorDealwith(e: e)
        }).disposed(by: disposeBag)
    }
    
    
    func loginSuccess(model: LoginApiModel) {
        
        Singleton.shared.token = model.token
//        Singleton.shared.token = "66UXJBkuwSs1t1_6yrTZH1CgMFSqhuu-hKInLwcaG5Y"
        Singleton.shared.refreshToken()
        SNBaseViewModel.isCanJumpLogin = true
        
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
