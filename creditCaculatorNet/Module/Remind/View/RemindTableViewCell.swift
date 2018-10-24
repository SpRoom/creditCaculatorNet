//
//  RemindTableViewCell.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/5.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class RemindTableViewCell: SNBaseTableViewCell {

    let bankNameL = UILabel().then {
        $0.font = Font(28)
    }
    let bankCardNumL = UILabel().then {
        $0.font = Font(28)
    } // 后四位
    let reimbursementTL = UILabel().then {
        $0.font = Font(28)
    }
    let reimburesementDateL = UILabel().then {
        $0.font = Font(28)
    }
    let stayTL = UILabel().then {
        $0.font = Font(28)
    }
    let stayValueL = UILabel().then {
        $0.font = Font(28)
    }
    let statusL = UILabel().then {
        $0.font = Font(28)
    }

}

extension RemindTableViewCell {
    
    override func setupView() {
        
        contentView.addSubviews(views: [bankNameL,bankCardNumL,reimbursementTL,reimburesementDateL,stayTL,stayValueL,statusL])
        
        bankNameL.snp.makeConstraints { (make) in
            make.left.snEqualTo(30)
            make.top.snEqualTo(30)
        }
        
        bankCardNumL.snp.makeConstraints { (make) in
            make.left.snEqualTo(bankNameL.snp.right).snOffset(20)
            make.centerY.snEqualTo(bankNameL)
        }
        
        reimbursementTL.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(460)
            make.centerY.snEqualTo(bankNameL)
        }
        
        reimburesementDateL.snp.makeConstraints { (make) in
            make.left.snEqualTo(reimbursementTL.snp.right).snOffset(20)
            make.centerY.snEqualTo(bankNameL)
        }
        
        stayTL.snp.makeConstraints { (make) in
            make.left.snEqualTo(bankNameL.snp.left)
            make.top.snEqualTo(bankNameL.snp.bottom).snOffset(30)
            make.bottom.snEqualToSuperview().snOffset(-30)
        }
        
        stayValueL.snp.makeConstraints { (make) in
            make.left.snEqualTo(bankCardNumL.snp.left)
            make.centerY.snEqualTo(stayTL)
        }
        
        statusL.snp.makeConstraints { (make) in
            make.right.snEqualTo(reimburesementDateL.snp.right)
            make.centerY.snEqualTo(stayTL)
        }
        
        stayTL.text = "待还"
        reimbursementTL.text = "还款日"
    }
    
    func set(bankName: String, carNumL: String, date: String, value: String, status: String) {
        self.bankNameL.text = bankName
        self.bankCardNumL.text = carNumL
        self.reimburesementDateL.text = date
        self.stayValueL.text = value
        self.statusL.text = status
    }
}
