//
//  Consumption ViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/16.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxDataSources
import SNSwiftPackage

class ConsumptionViewController: SNBaseViewController {

    let table = SNBaseTableView()
    
    
    let vmodel = ConsumptionViewModel()

}

extension ConsumptionViewController {
    
    override func loadData() {
        vmodel.credits()
    }
    
    override func setupView() {
        
        table.registers([ConsumptionTableViewCell.self])
        
        view.addSubview(table)
        
        table.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.bottom.snBottomSuperview(vc: self)
        }
        
        
        
    }
    
    override func bindEvent() {
        
        vmodel.sectionRep1.accept(vmodel.initSectionItems)
        
        let dataSource = self.dataSource()
        vmodel.sectionRep1.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        table.rx.modelSelected(ConsumptionItem.self)
            .subscribe(onNext: { (item) in
                self.addMonthBill(item: item)
            }).disposed(by: disposeBag)
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
    
    func addMonthBill(item: ConsumptionItem) {
        
        let vc = AddMonthBillViewController()
        vc.set(bankName: item.bankName, accountType: item.accountType, accountId: item.id, cardNo: item.cardNo.bankCardNoValue)
        self.vmodel.jumpSubject.onNext((vc,.push))
    }
}
extension ConsumptionViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<ConsumptionItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<ConsumptionItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            let cell : ConsumptionTableViewCell = table.dequeueReusableCell(forIndexPath: index)
            cell.set(bankName: item.bankName, cardNo: item.cardNo, billDate: item.billDate, reimbursementDate: item.reimbursementDate, totalValue: item.totalValue, status: item.status, temporaryValue: item.temporaryValue)
            return cell
            
        })
        
    }
}
