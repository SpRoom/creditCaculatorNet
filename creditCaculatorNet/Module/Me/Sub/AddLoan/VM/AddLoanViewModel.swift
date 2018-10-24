//
//  AddLoanViewModel.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/9.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage
class AddLoanViewModel: SNBaseViewModel {

    let nameRep = BehaviorRelay(value: "")
    let totalRep = BehaviorRelay(value: "")
    let borrowDateRep = BehaviorRelay(value: "")
    let repayDateRep = BehaviorRelay(value: "")
    let instalmentRep = BehaviorRelay(value: "")
    
}


extension AddLoanViewModel {
    
    func add() {
        
        let nameStr = nameRep.value
        let totalStr = totalRep.value
        let borrowStr = borrowDateRep.value
        let repayStr = repayDateRep.value
        let instalmentStr = instalmentRep.value
        
        if nameStr.isEmpty || totalStr.isEmpty || borrowStr.isEmpty || repayStr.isEmpty {
            SNLog("有参数为空")
            return
        }
        
        guard let totalD = Double(totalStr) else {
            SNLog("总额不对")
            return
        }
        guard let reimseI = Int(repayStr) else {
            SNLog("还款日不对")
            return
        }
        
        
        
        
    }
    
}
