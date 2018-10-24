//
//  AddCreditCardViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/6.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class AddCreditCardViewController: SNBaseViewController {

    let bankNameV = AuthTitleInputView()
    let cardNoV = AuthTitleInputView()
    let totalLinesV = AuthTitleInputView()
    let temporaryLinesV = AuthTitleInputView()
    let billDateV = AuthTitleInputView()
    let reimsementV = AuthTitleInputView()

    
    let btn = UIButton()
}


extension AddCreditCardViewController {
    
    override func setupView() {
        
        title = "添加信用卡"
        
        view.addSubviews(views: [bankNameV,cardNoV,totalLinesV,temporaryLinesV,billDateV,reimsementV,btn])
        
        bankNameV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        cardNoV.snp.makeConstraints { (make) in
            make.top.snEqualTo(bankNameV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        totalLinesV.snp.makeConstraints { (make) in
            make.top.snEqualTo(cardNoV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        temporaryLinesV.snp.makeConstraints { (make) in
            make.top.snEqualTo(totalLinesV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        billDateV.snp.makeConstraints { (make) in
            make.top.snEqualTo(temporaryLinesV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        reimsementV.snp.makeConstraints { (make) in
            make.top.snEqualTo(billDateV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        btn.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.right.snEqualToSuperview().snOffset(-30)
            make.top.snEqualTo(reimsementV.snp.bottom).snOffset(30)
            make.height.snEqualTo(90)
        }
        
        btn.setGradient(colors: [.yellow,.red], startPoint: CGPoint(x: 0, y: 0.8), endPoint: CGPoint(x: 0.4, y: 0.8))
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(.white, for: .normal)
    }
    
    override func bindEvent() {
        
        bankNameV.set(title: "银行名", placeholder: "请输入银行名")
        cardNoV.set(title: "卡号", placeholder: "请输入卡号")
        totalLinesV.set(title: "额度", placeholder: "请输入额度")
        temporaryLinesV.set(title: "临时额度", placeholder: "请输入临时额度")
        billDateV.set(title: "账单日", placeholder: "请输入账单日")
        reimsementV.set(title: "还款日", placeholder: "请输入还款日")
        
        btn.rx.tap.subscribe(onNext: {
            self.add()
        }).disposed(by: disposeBag)
    }
}


extension AddCreditCardViewController {
    
    func add() {
        
       let bankName = bankNameV.fieldV.text!
       let cardNo = cardNoV.fieldV.text!
        let totalLines = totalLinesV.fieldV.text!
        let temporary = temporaryLinesV.fieldV.text!
        let billDate = billDateV.fieldV.text!
        let reimsement = reimsementV.fieldV.text!
        
  
        
        if bankName.isEmpty || cardNo.isEmpty || totalLines.isEmpty || temporary.isEmpty || billDate.isEmpty || reimsement.isEmpty {
            
            print("有参数为空")
            return
        }
        
        
        let billDateI = Int(billDate) ?? 0
        let reimsementI = Int(reimsement) ?? 0
        let temporaryD = Double(temporary) ?? 0
        let totalLinesD = Double(totalLines) ?? 0
        
        
    }
}
