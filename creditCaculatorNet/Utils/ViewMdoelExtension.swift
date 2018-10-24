//
//  ViewMdoelExtension.swift
//  changshoubao
//
//  Created by spectator Mr.Z on 2018/9/20.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage

extension SNBaseViewModel {
    
    
    
    func netFailDeailWith(code: String, msg: String, callBack: (()->())?) {
        
        if code == "99" {
            if isCanJumpLogin {
                SZHUD("请先登录", type: .info, callBack: nil)
                isCanJumpLogin = false
                let vc = LoginViewController()
//                vc.state = .login
//                vc.popCallBack = {
//                    self.isCanJumpLogin = true
//                }
                self.jumpSubject.onNext((vc,.push))
                
            }
        } else {
            
            SZHUD(msg, type: .info, callBack: callBack)
        }
    }
    
    func netErrorDealwith(e: Error) {
        
        SZHUD(e.localizedDescription, type: .error, callBack: nil)
    }
    
//    func singleUserInfo() -> HLFLoginApiModel? {
//        guard let user = HLFSingleton.shared.user else {
//            if isCanJumpLogin {
//                SZHUD("请先登录", type: .info, callBack: nil)
//                isCanJumpLogin = false
//                let vc = LoginViewController()
////                vc.state = .login
//                vc.popCallBack = {
//                    self.isCanJumpLogin = true
//                }
//                self.jumpSubject.onNext((vc,.push))
//
//            }
//            return nil
//        }
//        return user
//    }
    
    func singleUserToken() -> String? {
        guard let user = Singleton.shared.token else {
//            if isCanJumpLogin {
//                SZHUD("请先登录", type: .info, callBack: nil)
//                isCanJumpLogin = false
//                let vc = LoginViewController()
//                //                vc.state = .login
//                vc.popCallBack = {
//                    self.isCanJumpLogin = true
//                }
//                self.jumpSubject.onNext((vc,.push))
//                
//            }
            return nil
        }
        return user
    }
    
    
}
