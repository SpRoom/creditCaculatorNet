//
//  CreditManagerViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/6.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import SNSwiftPackage
class CreditManagerViewController: SNBaseViewController {

    let table = SNBaseTableView()
    
    
    let vmodel = CreditManagerViewModel()

}

extension CreditManagerViewController{
    
    override func setupView() {
        
        title = "信用卡管理"
        
        table.registers([CreditManagerTableViewCell.self])
        
        view.addSubview(table)
        
        table.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.bottom.snBottomSuperview(vc: self)
        }
        
        naviButton(navigationItem, target: self, action: #selector(addCredit), point: .right, title: "添加", titleColor: .black)
    }
    
    override func bindEvent() {
        
        vmodel.sectionRep1.accept(vmodel.initSectionItems)
        
        let dataSource = self.dataSource()
        vmodel.sectionRep1.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    
        table.rx.modelSelected(CreditManagerItem.self).observeOn(MainScheduler.instance).subscribe(onNext: { (item) in
            self.alert(id: item.id)
        }).disposed(by: disposeBag)
    
    }
    
    func alert(id: Int) {
        
        let alert = UIAlertController(style: UIAlertController.Style.actionSheet)
        alert.set(title: "请选择操作", font: Font(40), color: .black)
        
        alert.addAction(image: nil, title: "删除", color: .red, style: .default, isEnabled: true) { (action) in
            SNLog("dele this card")
            self.vmodel.deleCard(id: id)
        }
        
        alert.addAction(image: nil, title: "修改", color: .black, style: .default, isEnabled: true) { (action) in
            SNLog("modify this card")
            self.editCredit(id: id)
        }
        
        alert.addAction(image: nil, title: "取消", color: .black, style: .cancel, isEnabled: true, handler: nil)
        
        alert.show()
    }
    
    @objc func addCredit() {
        let vc = AddCreditCardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func editCredit(id: Int) {
        let vc = ModifyCreditViewController()
        vc.set(id: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadData() {
        vmodel.credits()
    }
}
extension CreditManagerViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<CreditManagerItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<CreditManagerItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            let cell : CreditManagerTableViewCell = table.dequeueReusableCell(forIndexPath: index)
            cell.set(bankName: item.bankName, cardNo: item.cardNo, billDate: item.billDate, reimbursementDate: item.reimbursementDate, totalValue: item.totalValue, status: item.status, temporaryValue: item.temporaryValue)
            return cell
            
        })
        
    }
}
