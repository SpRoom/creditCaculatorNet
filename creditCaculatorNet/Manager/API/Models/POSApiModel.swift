//
//  POSApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/30.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import SwiftyJSON

struct POSApiModel : SNSwiftyJSONAble {
    
    let name: String
    let id: Int
    
    init?(jsonData: JSON) {
        self.name = jsonData["name"].stringValue
        self.id = jsonData["id"].intValue
    }
}
