//
//  AddMonthBillViewController.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/8.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class AddMonthBillViewController: SNBaseViewController {

    let nameV = TitleTapSelectView()
    let accountTypeV = TitleTapSelectView()
    let cardNoV = TitleTapSelectView()
    let moneyV = AuthTitleInputView()
    let reimsementV = AuthTitleInputView()
    
    let vmodel = AddMonthBillViewModel()

    let commitBtn = BGButton().then {
        $0.set(content: "提交")
    }
    
}

extension AddMonthBillViewController {
    
    func set(bankName: String, accountType:String, accountId: Int, cardNo: String) {
        
        vmodel.bankNameRep <= bankName
        vmodel.accountTypeRep <= accountType
        vmodel.accountId = accountId
        vmodel.cardNoRep <= cardNo
    }
    
    override func setupView() {
        
        view.addSubviews(views: [nameV,accountTypeV,cardNoV,moneyV,reimsementV,commitBtn])
        
        nameV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        accountTypeV.snp.makeConstraints { (make) in
            make.top.snEqualTo(nameV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        cardNoV.snp.makeConstraints { (make) in
            make.top.snEqualTo(accountTypeV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        moneyV.snp.makeConstraints { (make) in
            make.top.snEqualTo(cardNoV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        reimsementV.snp.makeConstraints { (make) in
            make.top.snEqualTo(moneyV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        commitBtn.snp.makeConstraints { (make) in
                make.left.snEqualToSuperview().snOffset(30)
                make.right.snEqualToSuperview().snOffset(-30)
                make.top.snEqualTo(reimsementV.snp.bottom).snOffset(30)
                make.height.snEqualTo(90)
            
        }
    }
    
    override func bindEvent() {
        
        nameV.set(title: "银行名", detail: "", isAc: false)
        accountTypeV.set(title: "账户类型", detail: "", isAc: false)
        cardNoV.set(title: "卡号", detail: "", isAc: false)
        moneyV.set(title: "还款金额", placeholder: "请输入还款金额")
        reimsementV.set(title: "还款日", placeholder: "请输入还款日,如20180808")
        
        vmodel.bankNameRep.bind(to: nameV.detailL.rx.text).disposed(by: disposeBag)
        vmodel.accountTypeRep.bind(to: accountTypeV.detailL.rx.text).disposed(by: disposeBag)
        vmodel.cardNoRep.bind(to: cardNoV.detailL.rx.text).disposed(by: disposeBag)
        
        _ = moneyV.fieldV.rx.textInput <-> vmodel.moneyRep
        _ = reimsementV.fieldV.rx.textInput <-> vmodel.reimsementRep
        
        commitBtn.rx.tap
            .subscribe(onNext: {
                self.vmodel.add()
            }).disposed(by: disposeBag)
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
}
