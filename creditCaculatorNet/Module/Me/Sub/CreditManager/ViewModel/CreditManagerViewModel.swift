//
//  CreditManagerViewModel.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/6.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage
class CreditManagerViewModel: SNBaseViewModel {

    let sectionRep1 = BehaviorRelay(value: [TableSectionModel<CreditManagerItem>]())
    
    let initSectionItems : [TableSectionModel<CreditManagerItem>] = [
        TableSectionModel(title: "", items: [
           // CreditManagerItem(bankName: "中国一行", cardNo: "6217852000009446538", billDate: "5", reimbursementDate: "15", totalValue: "13000.00", temporaryValue: "0", status: "9000.00 待还", id: 0)
            ])
    ]

}


extension CreditManagerViewModel {
    
    func credits() {
        
        APIRequest(requestType: APIExp.accountlist, modelType: [accountApiModel.self]).subscribe(onNext: { (result) in
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
    
    func deleCard(id: Int) {
        
    }
}

extension CreditManagerViewModel {
    
    func parseCredits(models: [accountApiModel]) {
        let items = models.map(mapCreditItem)
        
        sectionRep1 <= [
            TableSectionModel(title: "", items: items)
        ]
    }
    
}



extension CreditManagerViewModel {
    
    func mapCreditItem(model: accountApiModel) -> CreditManagerItem {
        
        let lines = pointToYuan(value: model.lines)
        let temporary = pointToYuan(value: model.temporary)

        let item = CreditManagerItem(bankName: model.name, cardNo: model.cardNo, billDate: "\(model.billDate)", reimbursementDate: "\(model.reimsementDate)", totalValue: lines, temporaryValue: temporary, status: "", id: model.id)

        return item
    }
}
