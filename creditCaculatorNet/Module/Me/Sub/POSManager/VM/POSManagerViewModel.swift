//
//  POSManagerViewModel.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/11/29.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit
import RxCocoa
import SNSwiftPackage

class POSManagerViewModel: SNBaseViewModel {

   let sectionRep1 = BehaviorRelay(value: [TableSectionModel<POSItem>]())

}

extension POSManagerViewModel {
    
    func poslist() {
        
        APIRequest(requestType: APIExp.posList, modelType: [POSApiModel.self]).subscribe(onNext: { (result) in
            switch result {
            case .success(let models):
                self.parsePOSList(models: models)
            case let .fail(code, msg):
                self.netFailDeailWith(code: code, msg: msg, callBack: nil)
            default:
                break
            }
        }, onError: { (e) in
            self.netErrorDealwith(e: e)
        }).disposed(by: disposeBag)
    }
    
    
}

extension POSManagerViewModel {
    
    func parsePOSList(models: [POSApiModel]) {
        
        let items = models.map(mapPOSItem)
        
        sectionRep1 <= [
            TableSectionModel(title: "", items: items)
        ]
    }
}

extension POSManagerViewModel {
    
    func mapPOSItem(model: POSApiModel) -> POSItem {
        
        let item = POSItem.init(name: model.name, id: model.id)
        return item
    }
    
}


