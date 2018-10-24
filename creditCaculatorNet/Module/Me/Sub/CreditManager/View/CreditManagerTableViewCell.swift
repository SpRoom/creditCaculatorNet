//
//  CreditManagerTableViewCell.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/6.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
class CreditManagerTableViewCell: SNBaseTableViewCell {

    let bankNameL = UILabel().then {
        $0.font = Font(28)
    }
    let bankCardNumL = UILabel().then {
        $0.font = Font(28)
    }
    let billDateTL = UILabel().then {
        $0.font = Font(28)
    }
    let billDateL = UILabel().then {
        $0.font = Font(28)
    }
    let reimbursementTL = UILabel().then {
        $0.font = Font(28)
    }
    let reimbursementDateL = UILabel().then {
        $0.font = Font(28)
    }
    let totalValueTL = UILabel().then {
        $0.font = Font(28)
    }

    let totalValueL = UILabel().then {
        $0.font = Font(28)
    }
    let temporaryValueTL = UILabel().then {
        $0.font = Font(28)
    }
    
    let temporaryValueL = UILabel().then {
        $0.font = Font(28)
    }

    let statusL = UILabel().then {
        $0.font = Font(28)
        $0.numberOfLines = 0
    }
}

extension CreditManagerTableViewCell  {
    
    func set(bankName: String, cardNo: String, billDate: String, billDateT: String = "账单日", reimbursementDate: String, reimbursementT: String = "还款日", totalValue: String, totalValueT: String = "总额度", status: String, temporaryT: String = "临时额度", temporaryValue: String) {
        self.bankNameL.text = bankName
        self.bankCardNumL.text = cardNo
        self.billDateL.text = billDate
        self.billDateTL.text = billDateT
        self.reimbursementTL.text = reimbursementT
        self.reimbursementDateL.text = reimbursementDate
        self.totalValueTL.text = totalValueT
        self.totalValueL.text = totalValue
        self.statusL.text = status
        self.temporaryValueTL.text = temporaryT
        self.temporaryValueL.text = temporaryValue
    }
    
    override func setupView() {
        contentView.addSubviews(views: [bankNameL,bankCardNumL,billDateL,billDateTL,reimbursementTL,reimbursementDateL,totalValueTL,statusL,totalValueL,temporaryValueTL,temporaryValueL])
        
        bankNameL.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.top.snEqualToSuperview().snOffset(30)
        }
        
        bankCardNumL.snp.makeConstraints { (make) in
            make.left.snEqualTo(bankNameL.snp.left)
            make.top.snEqualTo(bankNameL.snp.bottom).snOffset(20)
        }
        
        billDateTL.snp.makeConstraints { (make) in
//            make.left.snEqualToSuperview().snOffset(600)
            make.centerY.snEqualTo(bankNameL)
        }
        
        billDateL.snp.makeConstraints { (make) in
            make.left.snEqualTo(billDateTL.snp.right).snOffset(10)
            make.centerY.snEqualTo(bankNameL)
            make.right.snEqualToSuperview().snOffset(-30)
        }
        
        reimbursementTL.snp.makeConstraints { (make) in
            make.top.snEqualTo(billDateTL.snp.bottom).snOffset(20)
            make.left.snEqualTo(billDateTL.snp.left)
        }
        
        reimbursementDateL.snp.makeConstraints { (make) in
            make.left.snEqualTo(reimbursementTL.snp.right).snOffset(10)
            make.centerY.snEqualTo(reimbursementTL)
            make.right.snEqualToSuperview().snOffset(-30)
        }
        totalValueTL.snp.makeConstraints { (make) in
            make.left.snEqualTo(bankNameL.snp.left)
            make.top.snEqualTo(bankCardNumL.snp.bottom).snOffset(20)
            
        }
        totalValueL.snp.makeConstraints { (make) in
            make.left.snEqualTo(temporaryValueTL.snp.right).snOffset(10)
            make.centerY.snEqualTo(totalValueTL)
        }
        
        statusL.snp.makeConstraints { (make) in
            make.top.snEqualTo(reimbursementTL.snp.bottom).snOffset(20)
            make.left.snEqualTo(reimbursementTL.snp.left)
            make.right.snEqualToSuperview().snOffset(-10)
            
        }
        
        temporaryValueTL.snp.makeConstraints { (make) in
            make.left.snEqualTo(bankNameL.snp.left)
            make.top.snEqualTo(totalValueTL.snp.bottom).snOffset(20)
            
        }
        
        temporaryValueL.snp.makeConstraints { (make) in
            make.left.snEqualTo(temporaryValueTL.snp.right).snOffset(10)
            make.centerY.snEqualTo(temporaryValueTL)
            make.bottom.snEqualToSuperview().snOffset(-30)
        }
        
        let line = UIView().then {
            $0.backgroundColor = color_gray_bg_f8f8f9
        }
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.snEqualToSuperview()
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(2)
        }
    }
}
