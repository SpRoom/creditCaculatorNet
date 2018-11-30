//
//  AddPOSViewController.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/29.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class AddPOSViewController: SNBaseViewController {

    let nameV = AuthTitleInputView()

    let commitBtn = BGButton().then {
        $0.set(content: "提交")
    }
    
    let vmodel = AddPOSViewModel()
}

extension AddPOSViewController {
    
    override func setupView() {
        
        title = "添加POS机"
        
        nameV.set(title: "设备名", placeholder: "请输入设备名")
        
        view.addSubviews(views: [nameV,commitBtn])
        
        nameV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        commitBtn.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.right.snEqualToSuperview().snOffset(-30)
            make.top.snEqualTo(nameV.snp.bottom).snOffset(30)
            make.height.snEqualTo(90)
            
        }
    }
    
    override func bindEvent() {
    
        _ = nameV.fieldV.rx.textInput <-> vmodel.nameRep
        
        commitBtn.rx.tap
            .subscribe(onNext: {
                self.vmodel.add()
            }).disposed(by: disposeBag)
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
}
