//
//  ModifyCreditViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/7.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage

class ModifyCreditViewModel: SNBaseViewModel {

    let bankNameRep = BehaviorRelay(value: "")
    let bankCardNoRep = BehaviorRelay(value: "")
    let linesRep = BehaviorRelay(value: "")
    let temporarylinesRep = BehaviorRelay(value: "")
    let billDateRep = BehaviorRelay(value: "")
    let repayDateRep = BehaviorRelay(value: "")
    let useLinesRep = BehaviorRelay(value: "")
    let accounttypeRep = BehaviorRelay(value: "--请选择--")
    
    var accountId = -1
    
    let typesRep = BehaviorRelay(value: [IDNameApiModel]())
    
    var id = -1
}

extension ModifyCreditViewModel {
    
    func info() {
        
        guard id > 0 else {
            SNLog("没有id")
            return
        }
        
        APIRequest(requestType: APIExp.accountInfo(id: id), modelType: accountInfoApiModel.self).subscribe(onNext: { (result) in
            switch result {
            case .success(let model):
                self.parseCredit(model: model)
            case .fail(code: let code, msg: let msg):
                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
            default:
                break
            }
        }, onError: { (e) in
            self.netErrorDealwith(e: e)
        }).disposed(by: disposeBag)
    }
    
    func add() {
        let bankName = bankNameRep.value
        let cardNo = bankCardNoRep.value
        let totalLines = linesRep.value
        let temporary = temporarylinesRep.value
        let billDate = billDateRep.value
        let reimsement = repayDateRep.value
        let useline = useLinesRep.value
        
        
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
        let uselineD = Double(useline) ?? 0
        let uselineI = Int(uselineD * 100)
        
        
        APIRequestBool(requestType: APIExp.editAccount(id: id, accountTypeId: accountId, name: bankName, cardNo: cardNo, lines: totalLinesI, temporary: temporaryI, userLines: uselineI, billDate: billDateI, reimsementDate: reimsementI)).subscribe(onNext: { (result) in
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
        
//        APIRequestBool(requestType: APIExp.addAccount(accountTypeId: accountId, name: bankName, cardNo: cardNo, lines: totalLinesI, temporary: temporaryI, billDate: billDateI, reimsementDate: reimsementI)).subscribe(onNext: { (result) in
//            switch result {
//            case .bool(msg: let msg):
//                SZHUD(msg, type: .success, callBack: {
//                    self.jumpSubject.onNext((nil,.pop))
//                })
//            case .fail(code: let code, msg: let msg):
//                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
//            default:
//                break
//            }
//        }, onError: { (e) in
//            self.netErrorDealwith(e: e)
//        }).disposed(by: disposeBag)
    }
    
    func accountTypes() {
        
        APIRequest(requestType: APIExp.accountTypes, modelType: [IDNameApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let model):
                
                self.parseTypes(models: model)
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

extension ModifyCreditViewModel {
    
    func parseTypes(models: [IDNameApiModel]) {
        self.typesRep <= models
        if accountId > 0 && typesRep.value.count > 0 {
            
            for model in typesRep.value {
                
                if model.id == accountId {
                    accounttypeRep <= model.name
                }
            }
            
        }
    }
    
    func parseCredit(model: accountInfoApiModel) {
        
        let lines = pointToYuan(value: model.lines)
        let temporary = pointToYuan(value: model.temporary)
        let useline = pointToYuan(value: model.userLines)
        bankNameRep <= model.name
        bankCardNoRep <= model.cardNo
        linesRep <= lines
        temporarylinesRep <= temporary
        billDateRep <= "\(model.billDate)"
        repayDateRep <= "\(model.reimsementDate)"
        useLinesRep <= useline
        accountId = model.accountTypeId
        
        if accountId > 0 && typesRep.value.count > 0 {
            
            for model in typesRep.value {
                
                if model.id == accountId {
                    accounttypeRep <= model.name
                }
            }
            
        }
    }
}
