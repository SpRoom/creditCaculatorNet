//
//  ConsumptionItem.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/8.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation


struct ConsumptionItem: SectionItemType {
    
    var bankName: String
    var cardNo: String
    var billDate: String
    var reimbursementDate: String
    var totalValue: String
    var temporaryValue: String
    var status: String
    var id: Int
    var accountType: String
}
