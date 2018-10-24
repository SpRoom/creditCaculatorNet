//
//  LoanManagerItem.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/9.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation

struct LoanManagerItem : SectionItemType {
    
    var name: String
    var principal: String // 未还本金
    var reimbursement: String // 还款日
    var currentReimburValue: String // 本期还款金额
    let id : Int
    
}
