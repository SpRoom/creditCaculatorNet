//
//  RemindViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/5.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxDataSources
import SNSwiftPackage
class RemindViewController: SNBaseViewController {

let table = SNBaseTableView()

    
    let vmodel = RemindViewModel()
}


extension RemindViewController {
    
    override func setupView() {
        
        table.registers([RemindTableViewCell.self])
        
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
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
        
        table.rx.modelSelected(RemindItem.self).subscribe(onNext: { (item) in
            self.sheetAction(item: item)
        }).disposed(by: disposeBag)
    }
    
    override func loadData() {
        vmodel.reminds()
    }
    
    func sheetAction(item: RemindItem) {
        
        let alert = UIAlertController()
        alert.addAction(image: nil, title: "还款", color: nil, style: .default, isEnabled: true) { (action) in
//            self.addConsumptionBill(item: item)
            self.repay(item: item)
        }
      
        alert.addAction(image: nil, title: "取消", color: nil, style: .cancel, isEnabled: true) { (action) in
            
        }
        
        alert.show()
    }
    
    func repay(item: RemindItem) {
        
        let vc = RepayViewController()
        
        self.vmodel.jumpSubject.onNext((vc,.push))
    }
}
extension RemindViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<RemindItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<RemindItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            let cell : RemindTableViewCell = table.dequeueReusableCell(forIndexPath: index)
            cell.set(bankName: item.bankName, carNumL: item.cardNum, date: item.date, value: item.value, status: item.status)
            return cell
            
        })
        
    }
}
