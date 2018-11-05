//
//  LoanManagerViewModel.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/9.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage
class LoanManagerViewModel: SNBaseViewModel {

    let sectionRep1 = BehaviorRelay(value: [TableSectionModel<LoanManagerItem>]())
    
    let initSectionItems : [TableSectionModel<LoanManagerItem>] = [
        TableSectionModel(title: "", items: [
            LoanManagerItem(name: "蚂蚁花呗", principal: "10000", reimbursement: "9", currentReimburValue: "1000", id: 1)
            ])
    ]

}

extension LoanManagerViewModel {
    
    func loans() {
        
        APIRequest(requestType: APIExp.loans, modelType: [LoanApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let model):
                self.parseLoans(models: model)
            case .fail(code: let code, msg: let msg):
                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
            default:
                break
            }
        }, onError: { (e) in
            self.netErrorDealwith(e: e)
        }).disposed(by: disposeBag)

    }
    
    func dele(id: Int) {
       
    }
}

extension LoanManagerViewModel {
    
    func parseLoans(models: [LoanApiModel]) {
        
        let items = models.map(mapLoanItem)
        
        sectionRep1 <= [
            TableSectionModel(title: "", items: items)
        ]
    }
}

extension LoanManagerViewModel {
    
    func mapLoanItem(model: LoanApiModel) -> LoanManagerItem {
        
        let reimsementValue = pointToYuan(value: model.reimsementValue)
        let principay = pointToYuan(value: model.principay)
        
        let item = LoanManagerItem(name: model.name, principal: principay, reimbursement: "\(model.reimsementDate)", currentReimburValue: reimsementValue, id: model.id)
        
        return item
    }
}
