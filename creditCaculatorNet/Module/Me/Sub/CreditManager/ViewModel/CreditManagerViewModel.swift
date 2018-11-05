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
            CreditManagerItem(bankName: "中国一行", cardNo: "6217852000009446538", billDate: "5", reimbursementDate: "15", totalValue: "13000.00", temporaryValue: "0", status: "9000.00 待还", id: 0)
            ])
    ]

}


extension CreditManagerViewModel {
    
    func credits() {
        
        
    }
    
    func deleCard(id: Int) {
        
    }
}

extension CreditManagerViewModel {
    
//    func mapCreditItem(model: CreditCard) -> CreditManagerItem {
//
//        let item = CreditManagerItem(bankName: model.bankName, cardNo: model.cardNo, billDate: "\(model.billDate)", reimbursementDate: "\(model.reimsement)", totalValue: "\(model.totalLines)", temporaryValue: "\(model.temporaryLines)", status: "", id: model.id)
//
//        return item
//    }
}
