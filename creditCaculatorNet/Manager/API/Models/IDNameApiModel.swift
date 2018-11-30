//
//  IDNameApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/25.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import SwiftyJSON

struct IDNameApiModel : SNSwiftyJSONAble, SectionItemType {
    /// id
    let id: Int
    /// 名称
    let name: String
    init?(jsonData: JSON) {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
    }
    
    init(id: Int, name: String) {
        
        self.id = id
        self.name = name
    }
}
