//
//  RemindViewModel.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/5.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage

class RemindViewModel: SNBaseViewModel {

    let sectionRep1 = BehaviorRelay(value: [TableSectionModel<RemindItem>]())
    
    let initSectionItems : [TableSectionModel<RemindItem>] = [
        TableSectionModel(title: "", items: [
//            RemindItem(bankName: "bankName", cardNum: "1234", date: "2018-08-08", value: "1000.00", status: "status")
            ])
    ]
    
    
}

extension RemindViewModel {
    
    func reminds() {
        
        APIRequest(requestType: APIExp.bills, modelType: [BillsApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let model):
                self.parse(models: model)
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

extension RemindViewModel {
    
    func parse(models: [BillsApiModel]) {
        
       let items = models.map(mapRemindItem)
        
        sectionRep1 <= [
            TableSectionModel(title: "", items: items)
        ]
    }
    
    func mapRemindItem(model: BillsApiModel) -> RemindItem {
        
       let date = getTimeBy(timeStamp: "\(model.reimnursementDate)", format: "MM-dd")
        let money = String(format: "%.2f", Float(model.money)/100)

        var item : RemindItem! = RemindItem(bankName: model.accountName, cardNum: model.accountNo, date: date, value: money, status: model.status == 0 ? "未还" : "已还")
        
        
        return item
    }
}
