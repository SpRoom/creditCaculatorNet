//
//  LoanApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/25.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import SwiftyJSON


struct LoanApiModel : SNSwiftyJSONAble {
    
    /// loan id
    var id: Int
    /// loan 名称
    var name: String
    /// 状态 0.未还 1.已还
    var status: Int
    /// 本金
    var principay: Int
    /// 当前还款金额
    var reimsementValue: Int
    /// 每月还款日
    var reimsementDate: Int
    
    
    init?(jsonData: JSON) {
        self.reimsementValue = jsonData["reimsementValue"].intValue
        self.name = jsonData["name"].stringValue
        self.id = jsonData["id"].intValue
        self.status = jsonData["status"].intValue
        self.principay = jsonData["principay"].intValue
        self.reimsementDate = jsonData["reimsementDate"].intValue
    } 
}
