//
//  AddCreditCardViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/25.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage


class AddCreditCardViewModel: SNBaseViewModel {

    let bankNameRep = BehaviorRelay(value: "")
    let bankCardNoRep = BehaviorRelay(value: "")
    let linesRep = BehaviorRelay(value: "")
    let temporarylinesRep = BehaviorRelay(value: "")
    let billDateRep = BehaviorRelay(value: "")
    let repayDateRep = BehaviorRelay(value: "")
    let accounttypeRep = BehaviorRelay(value: "--请选择--")
    
    var accountId = -1

    let typesRep = BehaviorRelay(value: [IDNameApiModel]())
    
}


extension AddCreditCardViewModel {
    
    
    func add() {
        let bankName = bankNameRep.value
        let cardNo = bankCardNoRep.value
        let totalLines = linesRep.value
        let temporary = temporarylinesRep.value
        let billDate = billDateRep.value
        let reimsement = repayDateRep.value
        
        
        
        if bankName.isEmpty || cardNo.isEmpty || totalLines.isEmpty || temporary.isEmpty || billDate.isEmpty || reimsement.isEmpty {
            
            print("有参数为空")
            return
        }
        
        guard accountId > 0 else {
            SNLog("账户类型不能为空")
            return
        }
        
        
        let billDateI = Int(billDate) ?? 0
        let reimsementI = Int(reimsement) ?? 0
        let temporaryD = Double(temporary) ?? 0
        let temporaryI = Int(temporaryD * 100) 
        let totalLinesD = Double(totalLines) ?? 0
        let totalLinesI = Int(totalLinesD * 100) 
        
        
        APIRequestBool(requestType: APIExp.addAccount(accountTypeId: accountId, name: bankName, cardNo: cardNo, lines: totalLinesI, temporary: temporaryI, billDate: billDateI, reimsementDate: reimsementI)).subscribe(onNext: { (result) in
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
    
    
    func accountTypes() {
        
        APIRequest(requestType: APIExp.accountTypes, modelType: [IDNameApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let model):
                self.typesRep <= model
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
