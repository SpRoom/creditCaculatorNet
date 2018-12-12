//
//  RepayViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/12/2.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import RxCocoa
import RxSwift

class RepayViewModel: SNBaseViewModel {
    
    let nameRep = BehaviorRelay(value: "")
    let cardnoRep = BehaviorRelay(value: "")
    
    
    var moneyRep = BehaviorRelay(value: "")
    
    var maxMoney = 0

    var billId = -1
}

extension RepayViewModel {
    
    var moneyFinalRep: Observable<String> {
        return moneyRep.map(fliterMax)
    }
    
    func fliterMaxMoney(money: String) -> BehaviorRelay<String> {
        
        let point = yuanToPoint(value: money)
        
        if point > maxMoney {
            return BehaviorRelay(value: "\(maxMoney)")
        } else {
            return BehaviorRelay(value: money)
        }
    }
    
    func fliterMax(money: String) -> String {
        
        let point = yuanToPoint(value: money)
        
        if point > maxMoney {
            return "\(maxMoney)"
        } else {
            return money
        }
    }
    
    func filterMaxValue() {
        
        let money = moneyRep.value
        
        let point = yuanToPoint(value: money)
        
        if point > maxMoney {
            self.moneyRep <= "\(maxMoney)"
        }
        
    }
}

extension RepayViewModel {
    
    
    func repay() {
        
        guard billId > 0 else {
            
            SZHUD("账户id异常", type: .info, callBack: nil)
            return
        }
        
        let moneystr = moneyRep.value
        let money = yuanToPoint(value: moneystr)
        
        guard money > 0 else {
            SZHUD("还款金额不能小于1分", type: .info, callBack: nil)
            return
        }
        
        APIRequestBool(requestType: APIExp.repay(billId: billId, money: money)).subscribe(onNext: { (result) in
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
