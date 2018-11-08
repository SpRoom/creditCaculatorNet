//
//  consumptionCreditApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/8.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import SwiftyJSON

struct consumptionCreditApiModel : SNSwiftyJSONAble {
    /// 还款日
    let reimsementDate: Int
    /// 名称
    let name: String
    /// id
    let id: Int
    /// 账单日
    let billDate: Int
    /// 额度
    let lines: Int
    /// 类型id
    let accountTypeId: Int
    /// 卡号
    let cardNo: String
    /// 临时额度
    let balance: Int
    /// 状态信息
    var statusMsg : String
    /// 账户分类
    var accountType: String
    
    init?(jsonData: JSON) {
        self.reimsementDate = jsonData["reimsementDate"].intValue
        self.name = jsonData["name"].stringValue
        self.id = jsonData["id"].intValue
        self.billDate = jsonData["billDate"].intValue
        self.lines = jsonData["lines"].intValue
        self.accountTypeId = jsonData["accountTypeId"].intValue
        self.cardNo = jsonData["cardNo"].stringValue
        self.balance = jsonData["balance"].intValue
        self.statusMsg = jsonData["statusMsg"].stringValue
        self.accountType = jsonData["accountType"].stringValue
    }
}
