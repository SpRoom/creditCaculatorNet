//
//  MeViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/5.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxDataSources
import SNSwiftPackage
class MeViewController: SNBaseViewController {

    let table = SNBaseTableView()
    
    
    let vmodel = MeViewModel()

}

extension MeViewController {
    
    override func setupView() {
        
        table.registers([UITableViewCell.self])
        
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
        vmodel.sectionRep1.asObservable().bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        table.rx.modelSelected(MeItem.self).subscribe(onNext: { (item) in
            switch item {
            case .info(name: let name):
                self.jump(name: name)
            }
            
        }).disposed(by: disposeBag)
    }
    
    func jump(name: String) {
        
        if name ==  "银行卡管理" {
            let vc = CreditManagerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if name == "贷款管理" {
            let vc = LoanManagerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if name == "月账单统计" {
            self.vmodel.logOut()
        
        }
    }
}

extension MeViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<MeItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<MeItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            switch item {
            case let .info(name):
                let cell : UITableViewCell = table.dequeueReusableCell(forIndexPath: index)
                cell.textLabel?.text = name
                cell.textLabel?.font = Font(26)
                return cell
            }
            
            
        })
        
    }
}
