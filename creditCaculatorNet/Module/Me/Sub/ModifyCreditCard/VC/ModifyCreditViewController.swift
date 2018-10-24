//
//  ModifyCreditViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/15.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class ModifyCreditViewController: SNBaseViewController {

    
    let totalLinesV = AuthTitleInputView()
    let temporaryLinesV = AuthTitleInputView()
    let billDateV = AuthTitleInputView()
    let reimsementV = AuthTitleInputView()
    
    
    let btn = UIButton()

}

extension ModifyCreditViewController {
    
    override func setupView() {
        
        title = "编辑信用卡"
        
        view.addSubviews(views: [totalLinesV,temporaryLinesV,billDateV,reimsementV,btn])
        
        totalLinesV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
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
        
        totalLinesV.set(title: "额度", placeholder: "请输入额度")
        temporaryLinesV.set(title: "临时额度", placeholder: "请输入临时额度")
        billDateV.set(title: "账单日", placeholder: "请输入账单日")
        reimsementV.set(title: "还款日", placeholder: "请输入还款日")
        
        btn.rx.tap.subscribe(onNext: {
            self.save()
        }).disposed(by: disposeBag)
    }
}

extension ModifyCreditViewController {
    
    func save() {
        
        let totalLines = totalLinesV.fieldV.text!
        let temporary = temporaryLinesV.fieldV.text!
        let billDate = billDateV.fieldV.text!
        let reimsement = reimsementV.fieldV.text!
        
        guard let id = value(forKey: "id") as? Int else {
            print("没有id")
            return
        }
        
        if totalLines.isEmpty || temporary.isEmpty || billDate.isEmpty || reimsement.isEmpty {
            
            print("有参数为空")
            return
        }
        
        let billDateI = Int(billDate) ?? 0
        let reimsementI = Int(reimsement) ?? 0
        let temporaryD = Double(temporary) ?? 0
        let totalLinesD = Double(totalLines) ?? 0
        
     
    }
}
