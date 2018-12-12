//
//  RepayViewController.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/12/2.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import RxSwift

class RepayViewController: SNBaseViewController {

    /// 账户名
    let nameV = TitleTapSelectView()
    /// 卡号
    let cardnoV = TitleTapSelectView()
    /// 金额
    let moneyV = AuthTitleInputView().then {
        $0.fieldV.keyboardType = .decimalPad
    }
    
    let commitBtn = BGButton().then {
        $0.set(content: "提交")
    }
    
    let vmodel = RepayViewModel()
    
}

extension RepayViewController {
    
    func set(cardNo: String, name: String, money: String,billId: Int) {
        self.vmodel.nameRep <= name
        self.vmodel.cardnoRep <= cardNo
        self.vmodel.maxMoney = yuanToPoint(value: money)
        self.vmodel.moneyRep <= money
        self.vmodel.billId = billId
    }
    
    override func setupView() {
        
        title = "还款"
        
        nameV.set(title: "银行名", detail: "", isAc: false)
        cardnoV.set(title: "卡号", detail: "", isAc: false)
        moneyV.set(title: "还款金额", placeholder: "请输入还款金额")
        
        view.addSubviews(views: [nameV,cardnoV,moneyV,commitBtn])
        
        nameV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        cardnoV.snp.makeConstraints { (make) in
            make.top.snEqualTo(nameV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        moneyV.snp.makeConstraints { (make) in
            make.top.snEqualTo(cardnoV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        commitBtn.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.right.snEqualToSuperview().snOffset(-30)
            make.top.snEqualTo(moneyV.snp.bottom).snOffset(30)
            make.height.snEqualTo(90)
            
        }
        
    }
    
    override func bindEvent() {
        
        vmodel.nameRep.bind(to: nameV.detailL.rx.text).disposed(by: disposeBag)
        vmodel.cardnoRep.bind(to: cardnoV.detailL.rx.text).disposed(by: disposeBag)
        
        _ = moneyV.fieldV.rx.textInput <-> vmodel.moneyRep

        moneyV.fieldV.rx.controlEvent([.editingChanged]).asObservable()
            .subscribe(onNext: { [unowned self] in
                self.vmodel.filterMaxValue()
            }).disposed(by: disposeBag)
//        moneyV.fieldV.allControlEvents([.editingChanged])
//            .asObservable()
//            .subscribe(onNext: { [weak self] _ in
//                guard let `self` = self else { return }
//
//                // 获取非选中状态文字范围
//                let selectedRange = self.baseView.phoneField.markedTextRange
//                // 没有非选中文字，截取多出的文字
//                if selectedRange == nil {
//                    let text = self.baseView.phoneField.text ?? ""
//                    if text.count > 12 {
//                        let index = text.index(text.startIndex, offsetBy: 13)
//                        self.baseView.phoneField.text = String(text[..<index])
//                    }
//                }
//
//            })
//            .disposed(by: disposeBag)

        
        commitBtn.rx.tap.throttle(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vmodel.repay()
            }).disposed(by: disposeBag)
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
}
