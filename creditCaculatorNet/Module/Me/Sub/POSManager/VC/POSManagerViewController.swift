//
//  POSManagerViewController.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/29.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxDataSources
import SNSwiftPackage

class POSManagerViewController: SNBaseViewController {

    let table = SNBaseTableView()
    
    let vmodel = POSManagerViewModel()

}

extension POSManagerViewController {
    
    override func loadData() {
        vmodel.poslist()
    }
    
    override func setupView() {
        
        title = "设备管理"
        
        table.registers([UITableViewCell.self])
        
        view.addSubview(table)
        
        table.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.bottom.snBottomSuperview(vc: self)
        }
        
        naviButton(navigationItem, target: self, action: #selector(addPOS), point: .right, title: "添加", titleColor: .black)
    }
    
    override func bindEvent() {
        
        let dataSource = self.dataSource()
        vmodel.sectionRep1.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        vmodel.jumpSubject.subscribe(onNext: { (vc,type) in
            VCJump(VC: self, to: vc, type: type)
        }).disposed(by: disposeBag)
    }
    
    @objc func addPOS() {
        
        let vc = AddPOSViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension POSManagerViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<POSItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<POSItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            let cell : UITableViewCell = table.dequeueReusableCell(forIndexPath: index)
            cell.textLabel?.text = item.name
            return cell
            
        })
        
    }
}
