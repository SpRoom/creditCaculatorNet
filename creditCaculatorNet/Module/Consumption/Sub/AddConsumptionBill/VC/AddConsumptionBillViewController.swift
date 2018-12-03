//
//  AddConsumptionBillViewController.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/29.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import IQKeyboardManager
import RxSwift

class AddConsumptionBillViewController: SNBaseViewController {

    
    /// 账户名
    let nameV = TitleTapSelectView()
    /// 卡号
    let cardnoV = TitleTapSelectView()
    /// 消费类型
    let consumptionV = TitleTapSelectView()
    /// 金额
    let moneyV = AuthTitleInputView().then {
        $0.fieldV.keyboardType = .decimalPad
    }
    /// 还款日
    let reimsementV = AuthTitleInputView().then {
        $0.fieldV.keyboardType = .numberPad
    }
    /// 设备
    let deviceV = TitleTapSelectView()
    /// 备注
    let remarkV = AuthTitleInputView()
    
    let commitBtn = BGButton().then {
        $0.set(content: "提交")
    }
    
    let vmodel = AddConsumptionBillViewModel()
    
    
}

extension AddConsumptionBillViewController {
    
    func set(bankName: String, carnoV: String, accountId: Int) {
        vmodel.accountId = accountId
        vmodel.nameRep <= bankName
        vmodel.cardnoRep <= carnoV
    }
    
    override func setupView() {
        
        title = "消费"
        
        nameV.set(title: "银行名", detail: "", isAc: false)
        cardnoV.set(title: "卡号", detail: "", isAc: false)
        consumptionV.set(title: "消费类型", detail: "", isAc: true)
        moneyV.set(title: "消费金额", placeholder: "请输入消费金额")
        reimsementV.set(title: "消费日", placeholder: "请输入消费日,如20180808")
        deviceV.set(title: "设备", detail: "", isAc: true)
        remarkV.set(title: "备注", placeholder: "请输入备注")
        
        view.addSubviews(views: [nameV,cardnoV,consumptionV,moneyV,reimsementV,deviceV,remarkV,commitBtn])
        
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
        
        consumptionV.snp.makeConstraints { (make) in
            make.top.snEqualTo(cardnoV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        moneyV.snp.makeConstraints { (make) in
            make.top.snEqualTo(consumptionV.snp.bottom)
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
        
        deviceV.snp.makeConstraints { (make) in
            make.top.snEqualTo(reimsementV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        remarkV.snp.makeConstraints { (make) in
            make.top.snEqualTo(deviceV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        commitBtn.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.right.snEqualToSuperview().snOffset(-30)
            make.top.snEqualTo(remarkV.snp.bottom).snOffset(30)
            make.height.snEqualTo(90)
            
        }
    }
    
    override func bindEvent() {
        
        vmodel.nameRep.bind(to: nameV.detailL.rx.text).disposed(by: disposeBag)
        vmodel.cardnoRep.bind(to: cardnoV.detailL.rx.text).disposed(by: disposeBag)
        vmodel.consumptionRep.bind(to: consumptionV.detailL.rx.text).disposed(by: disposeBag)
        vmodel.deviceRep.bind(to: deviceV.detailL.rx.text).disposed(by: disposeBag)
        
        _ = moneyV.fieldV.rx.textInput <-> vmodel.moneyRep
        _ = reimsementV.fieldV.rx.textInput <-> vmodel.reimsementRep
         _ = remarkV.fieldV.rx.textInput <-> vmodel.remarkRep
        
        consumptionV.detailL.addTap(self, action: #selector(consumpTypeSelected))
        deviceV.detailL.addTap(self, action: #selector(posSelected))
        
        commitBtn.rx.tap.throttle(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vmodel.add()
            }).disposed(by: disposeBag)
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
}

extension AddConsumptionBillViewController {
    
    // 1.消费类型  2.设备选择
    func typeselected(type: Int) {
        
        IQKeyboardManager.shared().resignFirstResponder()
        
        let tap = UIButton().then {
            $0.backgroundColor = UIColor(white: 0, alpha: 0.6)
        }
        
        view.addSubview(tap)
        tap.snp.makeConstraints { (make) in
            make.top.left.right.snEqualToSuperview()
            make.bottom.snBottomSuperview(vc: self)
        }
        
        let picker = UIPickerView().then {
            $0.backgroundColor = .white
        }
        
        tap.addSubview(picker)
        
        picker.snp.makeConstraints { (make) in
            make.left.right.snEqualToSuperview()
            make.bottom.snBottomSuperview(vc: self)
            make.height.snEqualTo(500)
        }
        
        if type == 2 { // 设备选择
        vmodel.posTypeRep.map { (model) in
            return model.compactMap({ (model)  in
                return model.name
            })
            }.bind(to: picker.rx.items(adapter: vmodel.consumptionTypePickerAdapter)).disposed(by: disposeBag)
        } else {
            vmodel.consumptonTypesRep.map { (model) in
                return model.compactMap({ (model)  in
                    return model.name
                })
                }.bind(to: picker.rx.items(adapter: vmodel.consumptionTypePickerAdapter)).disposed(by: disposeBag)
        }
        
        
        let saveBtn = BGButton().then {
            $0.set(content: "确定")
        }
        
        let cancelBtn = BGButton().then {
            $0.set(content: "取消")
        }
        
        tap.addSubviews(views: [saveBtn,cancelBtn])
        saveBtn.snp.makeConstraints { (make) in
            make.right.snEqualToSuperview()
            make.bottom.snEqualTo(picker.snp.top)
            make.width.snEqualTo(300)
            make.height.snEqualTo(75)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview()
            make.bottom.snEqualTo(picker.snp.top)
            make.width.snEqualTo(300)
            make.height.snEqualTo(75)
        }
        
        
        tap.rx.tap.subscribe(onNext: {
            self.removeViews(tap)
        }).disposed(by: disposeBag)
        
        cancelBtn.rx.tap.subscribe(onNext: {
            self.removeViews(tap)
        }).disposed(by: disposeBag)
        
        saveBtn.rx.tap.subscribe(onNext: {
            if type == 2 { // 设备选择
            self.getPOSPickerValue(picker: picker)
            } else {
            self.getConsumptionTypePickerValue(picker: picker)
            }
            self.removeViews(tap)
        }).disposed(by: disposeBag)
        
    }
    
    @objc func posSelected() {
        
        typeselected(type: 2)

    }
    
    @objc func consumpTypeSelected() {
        typeselected(type: 1)
    }
    
    func removeViews(_ views: UIView...) {
        
        for v in views {
            
            v.removeFromSuperview()
            
        }
    }
    
    func getConsumptionTypePickerValue(picker: UIPickerView) {
        let index = picker.selectedRow(inComponent: 0)
        
        let model = vmodel.consumptonTypesRep.value[index]
        
        self.vmodel.consumptionType = model.id
        self.vmodel.consumptionRep <= model.name
        
    }
    
    func getPOSPickerValue(picker: UIPickerView) {
        
        let index = picker.selectedRow(inComponent: 0)
        
        let model = vmodel.posTypeRep.value[index]
        
        self.vmodel.device = model.id
        self.vmodel.deviceRep <= model.name
    }
}
