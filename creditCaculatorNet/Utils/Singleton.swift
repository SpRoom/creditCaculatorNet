//
//  Singleton.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation

class Singleton {
    
    private init() {}
    
    static let shared = Singleton()
    
    var token : String?
    
    func refreshToken() {
        let userDefaults = UserDefaults.standard
        
        if let user = token {
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            userDefaults.set(encodedData, forKey: "token")
        } else {
            userDefaults.removeObject(forKey: "token")
        }
    }
}
