//
//  AddLoanViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/9.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxSwift
import SNSwiftPackage

class AddLoanViewController: SNBaseViewController {

    let nameV = AuthTitleInputView()
    let totalValueV = AuthTitleInputView()
    let repayDateV = AuthTitleInputView()
    let borrowDateV = AuthTitleInputView()
    let instalmentAmountV = AuthTitleInputView()
    
    let checkBtn = UIButton().then {
        $0.setTitle("确认", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let vmodel = AddLoanViewModel()

}

extension AddLoanViewController {
    
    override func setupView() {
        
        title = "添加贷款"
        
        view.addSubviews(views: [nameV,totalValueV,borrowDateV,repayDateV,instalmentAmountV, checkBtn])
        
        nameV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        totalValueV.snp.makeConstraints { (make) in
            make.top.snEqualTo(nameV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        borrowDateV.snp.makeConstraints { (make) in
            make.top.snEqualTo(totalValueV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        repayDateV.snp.makeConstraints { (make) in
            make.top.snEqualTo(borrowDateV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        instalmentAmountV.snp.makeConstraints { (make) in
            make.top.snEqualTo(repayDateV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        checkBtn.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.right.snEqualToSuperview().snOffset(-30)
            make.top.snEqualTo(instalmentAmountV.snp.bottom).snOffset(30)
            make.height.snEqualTo(90)
        }
    }
    
    override func bindEvent() {
        
        nameV.set(title: "贷款名", placeholder: "请输入贷款名")
        totalValueV.set(title: "总计借款", placeholder: "总借款额度")
        borrowDateV.set(title: "借款日", placeholder: "请输入借款日,20180808")
        repayDateV.set(title: "还款日", placeholder: "请输入还款日")
        instalmentAmountV.set(title: "每期还款金额", placeholder: "请输入每期还款金额，使用,隔开")
        
       _ = nameV.fieldV.rx.textInput <-> vmodel.nameRep
        _ = totalValueV.fieldV.rx.textInput <-> vmodel.totalRep
        _ = borrowDateV.fieldV.rx.textInput <-> vmodel.borrowDateRep
        _ = repayDateV.fieldV.rx.textInput <-> vmodel.repayDateRep
        _ = instalmentAmountV.fieldV.rx.textInput <-> vmodel.instalmentRep
        
        checkBtn.rx.tap
            .subscribe(onNext: {
                self.vmodel.add()
            }).disposed(by: disposeBag)
    }

}
