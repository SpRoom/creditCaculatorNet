//
//  BillsApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/24.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import SwiftyJSON

struct BillsApiModel : SNSwiftyJSONAble {
    
    /// 账单id
    var id: Int
    /// 账户名
    var accountName: String
    /// 卡号
    var accountNo: String
    /// 账单类型 1.信用卡 2.贷款分期 3.信用卡分期
    var accountType: Int
    /// 状态 0.未还 1.已还
    var status: Int
    /// 金额;单位 分
    var money: Int
    /// 还款日
    var reimnursementDate: Int
    
    init?(jsonData: JSON) {
        self.status = jsonData["status"].intValue
        self.id = jsonData["id"].intValue
        self.reimnursementDate = jsonData["reimnursementDate"].intValue
        self.accountNo = jsonData["accountNo"].stringValue
        self.accountName = jsonData["accountName"].stringValue
        self.money = jsonData["money"].intValue
        self.accountType = jsonData["accountType"].intValue
    }

}
