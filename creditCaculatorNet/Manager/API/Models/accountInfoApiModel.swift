//
//  accountInfoApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/7.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import SwiftyJSON

struct accountInfoApiModel : SNSwiftyJSONAble {
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
    let temporary: Int
    /// 已用额度;单位 分
    var userLines: Int
    
    init?(jsonData: JSON) {
        self.reimsementDate = jsonData["reimsementDate"].intValue
        self.name = jsonData["name"].stringValue
        self.id = jsonData["id"].intValue
        self.billDate = jsonData["billDate"].intValue
        self.lines = jsonData["lines"].intValue
        self.accountTypeId = jsonData["accountTypeId"].intValue
        self.cardNo = jsonData["cardNo"].stringValue
        self.temporary = jsonData["temporary"].intValue
        self.userLines = jsonData["userLines"].intValue
    }
}
