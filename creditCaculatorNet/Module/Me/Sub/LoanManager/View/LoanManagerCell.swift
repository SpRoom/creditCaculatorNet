//
//  LoanManagerCell.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/9.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage

class LoanManagerCell: SNBaseTableViewCell {
    
    let nameL = UILabel().then {
        $0.font = Font(28)
    }
    
    let principayL = UILabel().then {
        $0.font = Font(28)
    }
    
    let reimbursementL = UILabel().then {
        $0.font = Font(28)
    }
    
    let currentReimbursementValueL = UILabel().then {
        $0.font = Font(28)
    }
    
}

extension LoanManagerCell {
    
    override func setupView() {
        
        contentView.addSubviews(views: [nameL,principayL,reimbursementL,currentReimbursementValueL])
        
        nameL.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.top.snEqualToSuperview().snOffset(30)
        }
        
        principayL.snp.makeConstraints { (make) in
            make.top.snEqualToSuperview().snOffset(30)
            make.right.snEqualToSuperview().snOffset(-30)
        }
        
        reimbursementL.snp.makeConstraints { (make) in
            make.top.snEqualTo(principayL.snp.bottom).snOffset(50)
            make.right.snEqualToSuperview().snOffset(-30)
            make.bottom.snEqualToSuperview().snOffset(-30)
        }
        
        currentReimbursementValueL.snp.makeConstraints { (make) in
            make.top.snEqualTo(nameL.snp.bottom).snOffset(30)
            make.left.snEqualToSuperview().snOffset(30)
        }
    }
    
    func set(name: String, principay: String, reimbursment: String, currentReimbursmentValue: String) {
        self.nameL.text = name
        self.principayL.text = principay
        self.reimbursementL.text = reimbursment
        self.currentReimbursementValueL.text = currentReimbursmentValue
    }
}
