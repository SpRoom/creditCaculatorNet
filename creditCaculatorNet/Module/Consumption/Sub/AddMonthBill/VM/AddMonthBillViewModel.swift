//
//  AddMonthBillViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/8.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage

class AddMonthBillViewModel: SNBaseViewModel {
    
    let bankNameRep = BehaviorRelay(value: "")
    let accountTypeRep = BehaviorRelay(value: "")
    let cardNoRep = BehaviorRelay(value: "")
    let moneyRep = BehaviorRelay(value: "")
    let reimsementRep = BehaviorRelay(value: "")
    
    var accountId = -1
}


extension AddMonthBillViewModel {
    
    func add() {
        
        let money = yuanToPoint(value: moneyRep.value)
        
        let reimsementStr = reimsementRep.value
        
        guard let date = dateFor(string: reimsementStr, format: "yyyyMMdd") else {
            SNLog("还款日不能为空")
            return
        }
        let reimsementTimeInterval = date.timeIntervalSince1970
        
        APIRequestBool(requestType: APIExp.addCreditMonthBill(accountId: accountId, accountType: 1, money: money, reimsementDate: reimsementTimeInterval)).subscribe(onNext: { (result) in
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
