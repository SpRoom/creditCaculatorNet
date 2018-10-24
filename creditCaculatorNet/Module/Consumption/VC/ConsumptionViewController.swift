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
    
    
    let vmodel = RemindViewModel()

}

extension ConsumptionViewController {
    
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
        
        table.rx.modelSelected(RemindItem.self)
            .subscribe(onNext: { (item) in
                print("")
            }).disposed(by: disposeBag)
        
    }
}
extension ConsumptionViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<RemindItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<RemindItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            let cell : RemindTableViewCell = table.dequeueReusableCell(forIndexPath: index)
            cell.set(bankName: item.bankName, carNumL: item.cardNum, date: item.date, value: item.value, status: item.status)
            return cell
            
        })
        
    }
}
