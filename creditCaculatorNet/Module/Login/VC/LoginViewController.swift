//
//  LoginViewController.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class LoginViewController: SNBaseViewController {

    let logoV = UIImageView().then {
        $0.image = Image("logo")
    }
    
    let usernameV = LoginIconInputClearView().then {
        $0.set(icon: "username", place: "输入用户名")
    }
    
    let passwordV = LoginIconInputClearView().then {
        $0.set(icon: "password", place: "输入密码")
    }
    
    let loginbtn = BGButton().then {
        $0.set(content: "登录")
    }
    

    let vmodel = LoginViewModel()
}

extension LoginViewController {
    
    override func setupView() {
        
        view.addSubviews(views: [logoV,usernameV,passwordV,loginbtn])
        
        logoV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self).snOffset(200)
            make.centerX.snEqualToSuperview()
            make.width.height.snEqualTo(250)
            
        }
        
        usernameV.snp.makeConstraints { (make) in
            make.top.snEqualTo(logoV.snp.bottom).snOffset(150)
            make.width.snEqualTo(680)
            make.height.snEqualTo(90)
            make.centerX.snEqualToSuperview()
        }
        
        passwordV.snp.makeConstraints { (make) in
            make.top.snEqualTo(usernameV.snp.bottom).snOffset(30)
            make.width.snEqualTo(680)
            make.height.snEqualTo(90)
            make.centerX.snEqualToSuperview()
        }
        
        loginbtn.snp.makeConstraints { (make) in
            make.top.snEqualTo(passwordV.snp.bottom).snOffset(80)
            make.width.snEqualTo(680)
            make.height.snEqualTo(90)
            make.centerX.snEqualToSuperview()
        }
        
    }
    
    override func bindEvent() {
        
        loginbtn.rx.tap
            .subscribe(onNext: {
                self.vmodel.loginSuccess()
            }).disposed(by: disposeBag)
    }
}
