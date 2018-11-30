//
//  AddPOSViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/29.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage

class AddPOSViewModel: SNBaseViewModel {
    
    let nameRep = BehaviorRelay(value: "")
}

extension AddPOSViewModel {
    
    func add() {
        
        let name = nameRep.value
        
        guard !name.isEmpty else {
            SZHUD("设备名不能为空", type: .info, callBack: nil)
            return
        }
        
        APIRequestBool(requestType: APIExp.addPos(name: name)).subscribe(onNext: { (result) in
            switch result {
            case .bool(msg: let msg):
                SZHUD(msg, type: .success, callBack: {
                    self.jumpSubject.onNext((nil,.pop))
                })
            case .fail(code: let code, msg: let msg):
                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
            default:
                break
            }
        }, onError: { (e) in
            self.netErrorDealwith(e: e)
        }).disposed(by: disposeBag)
    }
}
