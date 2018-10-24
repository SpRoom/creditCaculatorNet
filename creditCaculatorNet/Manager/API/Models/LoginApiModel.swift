//
//  LoginApiModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import SwiftyJSON

struct LoginApiModel: SNSwiftyJSONAble {
    
    var token: String
    
     init?(jsonData: JSON) {
        self.token = jsonData["token"].stringValue
    }
}
