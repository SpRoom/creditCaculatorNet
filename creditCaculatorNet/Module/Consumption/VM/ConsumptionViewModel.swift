//
//  ConsumptionViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/8.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import RxCocoa
import SNSwiftPackage

class ConsumptionViewModel : SNBaseViewModel {
    let sectionRep1 = BehaviorRelay(value: [TableSectionModel<ConsumptionItem>]())
    
    let initSectionItems : [TableSectionModel<ConsumptionItem>] = [
        TableSectionModel(title: "", items: [
            
            ])
    ]
}

extension ConsumptionViewModel {
    func credits() {
        
        APIRequest(requestType: APIExp.comsumptionCreditList, modelType: [consumptionCreditApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let models):
                self.parseCredits(models: models)
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

extension ConsumptionViewModel {
    func parseCredits(models: [consumptionCreditApiModel]) {
        let items = models.map(mapCreditItem)
        
        sectionRep1 <= [
            TableSectionModel(title: "", items: items)
        ]
    }
}

extension ConsumptionViewModel {
    
    func mapCreditItem(model: consumptionCreditApiModel) -> ConsumptionItem {
        
        let lines = pointToYuan(value: model.lines)
        let temporary = pointToYuan(value: model.balance)
        
        let item = ConsumptionItem(bankName: model.name, cardNo: model.cardNo, billDate: "\(model.billDate)", reimbursementDate: "\(model.reimsementDate)", totalValue: lines, temporaryValue: temporary, status: model.statusMsg, id: model.id, accountType: model.accountType)
        
        return item
    }
}
