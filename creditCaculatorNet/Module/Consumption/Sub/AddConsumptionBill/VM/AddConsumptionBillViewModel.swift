//
//  AddConsumptionBillViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/29.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import RxCocoa
import RxDataSources

class AddConsumptionBillViewModel: SNBaseViewModel {

    let nameRep = BehaviorRelay(value: "")
    let cardnoRep = BehaviorRelay(value: "")
    let consumptionRep = BehaviorRelay(value: "")
    let moneyRep = BehaviorRelay(value: "")
    let reimsementRep = BehaviorRelay(value: "")
    let deviceRep = BehaviorRelay(value: "")
    let remarkRep = BehaviorRelay(value: "")
    
    var accountId = -1
    var consumptionType = -1
    var device = -1
    
    let consumptonTypesRep = BehaviorRelay(value: [
            IDNameApiModel.init(id: 1, name: "消费"),
            IDNameApiModel.init(id: 2, name: "信用卡分期")
        ])
    let posTypeRep = BehaviorRelay(value: [IDNameApiModel]())
     let consumptionTypePickerAdapter = RxPickerViewStringAdapter<[String]>(components: [], numberOfComponents: { (_, _, _) -> Int in
        1
    }, numberOfRowsInComponent: { (_, _, items, _) -> Int in
        return items.count
    }) { (_, _, items, row, _) -> String? in
        return items[row]
    }
}

extension AddConsumptionBillViewModel {
    
    override func loading() {
        poslist()
    }
    
    func poslist() {
        
        APIRequest(requestType: APIExp.posList, modelType: [IDNameApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let models):
                self.posTypeRep <= models
            case let .fail(code, msg):
                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
            default:
                break
            }
        }, onError: { (e) in
            self.netErrorDealwith(e: e)
        }).disposed(by: disposeBag)
    }
    
    func add() {
        
        guard accountId > -1 else {
            SZHUD("账户不能为空", type: .info, callBack: nil)
            return
        }
        guard consumptionType > -1 else {
            SZHUD("消费类型不能为空", type: .info, callBack: nil)
            return
        }
        guard device > -1 else {
            SZHUD("设备不能为空", type: .info, callBack: nil)
            return
        }
        
        let money = yuanToPoint(value: moneyRep.value)
        
        guard money > 0 else {
            SZHUD("消费金额不正确", type: .info, callBack: nil)
            return
        }
        
        let reimsementStr = reimsementRep.value
        
        var reimsementTimeInterval : TimeInterval = 0
        if reimsementStr.isEmpty {
            reimsementTimeInterval = Date().timeIntervalSince1970
        } else {
        
        guard let date = dateFor(string: reimsementStr, format: "yyyyMMdd") else {
            SNLog("消费日不能为空")
            SZHUD("消费日不能为空", type: .info, callBack: nil)
            return
        }
        // 消费日时间戳
         reimsementTimeInterval = date.timeIntervalSince1970
        }
        let remark = remarkRep.value
        
        APIRequestBool(requestType: APIExp.addConsumptionBill(accountId: accountId, consumptionType: consumptionType, money: money, consumptionDate: reimsementTimeInterval, device: device, remark: remark)).subscribe(onNext: { (result) in
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
