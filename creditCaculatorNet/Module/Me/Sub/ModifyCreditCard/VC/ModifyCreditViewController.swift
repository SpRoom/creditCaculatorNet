//
//  ModifyCreditViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/15.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage
import RxDataSources

class ModifyCreditViewController: SNBaseViewController {

    
    let bankNameV = AuthTitleInputView()
    let cardNoV = AuthTitleInputView()
    let totalLinesV = AuthTitleInputView()
    let temporaryLinesV = AuthTitleInputView()
    let useLinesV = AuthTitleInputView()
    let billDateV = AuthTitleInputView()
    let reimsementV = AuthTitleInputView()
    let accountTypeV = TitleTapSelectView()
    
    
    let btn = BGButton()

    let vmodel = ModifyCreditViewModel()
    
    private let pickerAdapter = RxPickerViewStringAdapter<[String]>(components: [], numberOfComponents: { (_, _, _) -> Int in
        1
    }, numberOfRowsInComponent: { (_, _, items, _) -> Int in
        return items.count
    }) { (_, _, items, row, _) -> String? in
        return items[row]
    }
}

extension ModifyCreditViewController {
    
    override func loadData() {
        vmodel.accountTypes()
    }
    
    func set(id: Int) {
        
        vmodel.id = id
        
        vmodel.info()
    }
    
    override func setupView() {
        
        title = "编辑信用卡"
        
        view.addSubviews(views: [bankNameV,cardNoV,totalLinesV,temporaryLinesV,billDateV,reimsementV,btn,accountTypeV,useLinesV])
        
        bankNameV.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        accountTypeV.snp.makeConstraints { (make) in
            make.top.snEqualTo(bankNameV.snp.bottom)
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
        
        useLinesV.snp.makeConstraints { (make) in
            make.top.snEqualTo(temporaryLinesV.snp.bottom)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.height.snEqualTo(120)
        }
        
        billDateV.snp.makeConstraints { (make) in
            make.top.snEqualTo(useLinesV.snp.bottom)
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
        
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(.white, for: .normal)
    }
    
    override func bindEvent() {
        
        bankNameV.set(title: "银行名", placeholder: "请输入银行名")
        cardNoV.set(title: "卡号", placeholder: "请输入卡号")
        totalLinesV.set(title: "额度", placeholder: "请输入额度")
        temporaryLinesV.set(title: "临时额度", placeholder: "请输入临时额度")
        useLinesV.set(title: "已用额度", placeholder: "请输入已用额度")
        billDateV.set(title: "账单日", placeholder: "请输入账单日")
        reimsementV.set(title: "还款日", placeholder: "请输入还款日")
        accountTypeV.set(title: "账户类型", detail: "--请选择--", isAc: true)
        
        
        _ = bankNameV.fieldV.rx.textInput <-> vmodel.bankNameRep
        _ = cardNoV.fieldV.rx.textInput <-> vmodel.bankCardNoRep
        _ = totalLinesV.fieldV.rx.textInput <-> vmodel.linesRep
        _ = temporaryLinesV.fieldV.rx.textInput <-> vmodel.temporarylinesRep
        _ = billDateV.fieldV.rx.textInput <-> vmodel.billDateRep
        _ = reimsementV.fieldV.rx.textInput <-> vmodel.repayDateRep
        _ = useLinesV.fieldV.rx.textInput <-> vmodel.useLinesRep
        vmodel.accounttypeRep.bind(to: accountTypeV.detailL.rx.text).disposed(by: disposeBag)
        
        btn.rx.tap.subscribe(onNext: {
            self.vmodel.add()
        }).disposed(by: disposeBag)
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
}

extension ModifyCreditViewController {
    
    @objc func typeselected() {
        
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
        
        vmodel.typesRep.map { (model) in
            return model.compactMap({ (model)  in
                return model.name
            })
            }.bind(to: picker.rx.items(adapter: pickerAdapter)).disposed(by: disposeBag)
        
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
            self.getPickerValue(picker: picker)
            self.removeViews(tap)
        }).disposed(by: disposeBag)
    }
    
    func removeViews(_ views: UIView...) {
        
        for v in views {
            
            v.removeFromSuperview()
            
        }
    }
    
    func getPickerValue(picker: UIPickerView) {
        
        let index = picker.selectedRow(inComponent: 0)
        
        let model = vmodel.typesRep.value[index]
        
        self.vmodel.accountId = model.id
        self.vmodel.accounttypeRep <= model.name
    }
}
