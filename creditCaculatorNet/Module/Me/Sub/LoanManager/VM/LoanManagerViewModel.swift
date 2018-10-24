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
        

    }
    
    func dele(id: Int) {
       
    }
}

extension LoanManagerViewModel {
    
//    func mapLoanItem(model: Loan) -> LoanManagerItem {
//        
//        let item = LoanManagerItem(name: model.name, principal: "\(model.principal)", reimbursement: "\(model.reimsement)", currentReimburValue: "0", id: model.id)
//        
//        return item
//    }
}
