//
//  LoanManagerViewController.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/9.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxDataSources
import SNSwiftPackage
class LoanManagerViewController: SNBaseViewController {

    let table = SNBaseTableView()
    
    
    let vmodel = LoanManagerViewModel()
}

extension LoanManagerViewController {
    
    override func setupView() {
        
        title = "贷款管理"
        
        table.registers([LoanManagerCell.self])
        
        view.addSubview(table)
        
        table.snp.makeConstraints { (make) in
            make.top.snTopSuperview(vc: self)
            make.left.snEqualToSuperview()
            make.right.snEqualToSuperview()
            make.bottom.snBottomSuperview(vc: self)
        }
     
        naviButton(navigationItem, target: self, action: #selector(addLoan), point: .right, title: "添加", titleColor: .black)
        
    }
    
    override func bindEvent() {
        vmodel.sectionRep1.accept(vmodel.initSectionItems)
        
        let dataSource = self.dataSource()
        vmodel.sectionRep1.bind(to: table.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        table.rx.modelSelected(LoanManagerItem.self)
            .subscribe(onNext: { (item) in
                self.alert(id: item.id)
            }).disposed(by: disposeBag)
        
        
    }
    
    @objc func addLoan() {
        
        let vc = AddLoanViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadData() {
        vmodel.loans()
    }
    
    func alert(id: Int) {
        
        let alert = UIAlertController(style: UIAlertController.Style.actionSheet)
        alert.set(title: "请选择操作", font: Font(40), color: .black)
        
        alert.addAction(image: nil, title: "删除", color: .red, style: .default, isEnabled: true) { (action) in
            SNLog("dele this card")
            self.vmodel.dele(id: id)
        }
        
//        alert.addAction(image: nil, title: "修改", color: .black, style: .default, isEnabled: true) { (action) in
//            SNLog("modify this card")
//            self.editCredit(id: id)
//        }
        
        alert.addAction(image: nil, title: "取消", color: .black, style: .cancel, isEnabled: true, handler: nil)
        
        alert.show()
    }
}

extension LoanManagerViewController {
    
    func dataSource() ->RxTableViewSectionedReloadDataSource<TableSectionModel<LoanManagerItem>> {
        
        return RxTableViewSectionedReloadDataSource<TableSectionModel<LoanManagerItem>>(configureCell: { (ds, table, index, item) -> UITableViewCell in
            
            let cell : LoanManagerCell = table.dequeueReusableCell(forIndexPath: index)
            cell.set(name: item.name, principay: item.principal, reimbursment: item.reimbursement, currentReimbursmentValue: item.currentReimburValue)
            return cell
            
        })
        
    }
}
