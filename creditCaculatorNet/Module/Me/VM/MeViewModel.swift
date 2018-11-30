//
//  MeViewModel.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/5.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage

class MeViewModel: SNBaseViewModel {

    
    let sectionRep1 = BehaviorRelay(value: [TableSectionModel<MeItem>]())
    
    let initSectionItems : [TableSectionModel<MeItem>] = [
        TableSectionModel(title: "", items: [
            MeItem.info(name: "银行卡管理"),
            MeItem.info(name: "贷款管理"),
            MeItem.info(name: "设备管理"),
            MeItem.info(name: "月账单统计")
            ])
    ]
}
