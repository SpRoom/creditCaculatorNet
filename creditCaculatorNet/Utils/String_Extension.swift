//
//  String_Extension.swift
//  changshoubao
//
//  Created by spectator Mr.Z on 2018/9/27.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation


extension String {
    
    var moneyValue: String {
        let d = Double(self) ?? 0.0
        return String(format: "%0.2f", d)
    }
    
    var bankCardNoValue: String {
        let pre = self[safe: 0..<4] ?? ""
        
        let suffix = self[safe: self.count-4..<self.count] ?? ""
        
        let middle = "*" * (self.count-8)
        
        return pre+middle+suffix
    }
    
    var securePhoneValue: String {
        
        let pre = self[safe: 0..<3] ?? ""
        
        let suffix = self[safe: self.count-4..<self.count] ?? ""
        
        let middle = "*" * (self.count-7)
        
        return pre+middle+suffix
    }
    
}
