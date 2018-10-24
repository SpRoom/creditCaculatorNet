//
//  APIManager.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import SNSwiftPackage
import Moya


func APIRequest<T : SNSwiftyJSONAble>(requestType: APIExp, modelType: [T.Type]) -> Observable<SNMoyaResult<[T]>> {
    return APIProvider.rx.request(requestType).asObservable().map(to: modelType.self)
}


func APIRequest<T : SNSwiftyJSONAble>(requestType: APIExp, modelType: T.Type) -> Observable<SNMoyaResult<T>> {
    return APIProvider.rx.request(requestType).asObservable().map(to: modelType.self)
}

func APIRequest(requestType: APIExp) -> Observable<SNMoyaResult<String>> {
    return APIProvider.rx.request(requestType).asObservable().mapToString()
}


func APIRequestModel(requestType: APIExp) -> Observable<SNMoyaResult<SNNetModel>> {
    
    return APIProvider.rx.request(requestType).asObservable().mapToNetModel()
}

func APIRequestModel<T : SNSwiftyJSONAble>(requestType: APIExp, modelType: T.Type) -> Observable<SNMoyaResult<T>> {
    return APIProvider.rx.request(requestType).asObservable().mapToModel()
}

func APIRequestBool(requestType: APIExp) -> Observable<SNMoyaResult<Bool>> {
    return APIProvider.rx.request(requestType).asObservable().mapToHLFBool()
}

func APIRequestJSON(requestType: APIExp) -> Observable<SNMoyaResult<JSON>> {
    return APIProvider.rx.request(requestType).asObservable().mapToJSON()
}


extension Response {
    
    public func mapToHLFBool() throws -> SNMoyaResult<Bool> {
        let jsonData = try JSON(data: self.data)
        SNLog(jsonData)
        guard let model = HLFAPIModel(jsonData: jsonData) else {
            throw MoyaError.jsonMapping(self)
        }
        
        if let token = model.token ,token != SNAPIConfig.tokenAuth {
            
            print("token核对失败，请重新登录")
            //            return SNMoyaResult.fail(code: "99", msg: "token核对失败，请重新登录")
            return SNMoyaResult.login
        }
        
        guard model.code == SNAPIConfig.success_code else {
            return SNMoyaResult.fail(code: model.code, msg: model.msg)
        }
        return SNMoyaResult.bool(msg: model.msg)
    }
}

extension ObservableType where E == Response {
    
    public func mapToHLFBool() -> Observable<SNMoyaResult<Bool>> {
        return flatMap({ response -> Observable<SNMoyaResult<Bool>> in
            return Observable.just(try response.mapToHLFBool())
        })
    }
    
}

class HLFAPIModel: SNSwiftyJSONAble {
    
    var code : String
    var msg : String
    var data : String
    var token : String?
    
    required init?(jsonData: JSON) {
        self.code = jsonData["code"].stringValue
        self.msg = jsonData["msg"].stringValue
        self.data = jsonData["data"].stringValue
        self.token = jsonData["token"].string
    }
}
