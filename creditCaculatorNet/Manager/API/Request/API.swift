//
//  API.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SNSwiftPackage
import SwiftyJSON


let APIProvider = MoyaProvider<APIExp>()

enum APIExp {
    case login(username: String, password: String)
    case register(username: String, password: String)
    case changePassord(username: String, password: String, newPassword: String)
    case exit
    case bills
    case addLoan(name: String,lines: Int,reimsementDate:Int,borrowDate:TimeInterval,instaments: String)
    case loans
    case addAccount(accountTypeId: Int, name: String, cardNo: String, lines: Int, temporary: Int, billDate: Int, reimsementDate: Int)
    case accountTypes
    case accountlist
    case accountInfo(id: Int)
    case editAccount(id: Int, accountTypeId:Int,name:String,cardNo:String,lines:Int,temporary:Int,userLines:Int,billDate:Int,reimsementDate:Int)
}

extension APIExp : JSONMappableTargetType {
    
    var responseType: SNSwiftyJSONAble.Type {
        return SNNetModel.self
    }
    
    var baseURL: URL {
        return URL(string:baseUrl)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/v1/login"
        case .register:
            return "/api/v1/register"
        case .changePassord:
            return "/api/v1/changePassword"
        case .exit:
            return "/api/v1/exit"
        case .bills:
            return "/api/v1/bill/bills"
        case .addLoan:
            return "/api/v1/loan/addLoan"
        case .loans:
            return "/api/v1/loan/loans"
        case .addAccount:
            return "/api/v1/account/addAccount"
        case .accountTypes:
            return "/api/v1/account/accountTypes"
        case .accountlist:
            return "/api/v1/account/accountList"
        case .accountInfo:
            return "/api/v1/account/account"
        case .editAccount:
            return "/api/v1/account/editAccount"
        }
    }

    var method: Moya.Method {
        switch self {
        
            
        default:
            return .post
        }
        
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "")!
    }
    
    var task: Task {
        switch self {
       
        default:// indexData
            return taskPostResult()
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login,.register:
            return headerJSON()
        default:
            return headerJSONToken()
        }
        
    }
    
    
    
    func headerJSONToken() -> [String:String] {
        
        var header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        if let tk = Singleton.shared.token {
            header["X-AUTH-TOKEN"] = "\(tk)"
        }
        
        return header
    }
    
    func headerJSON() -> [String:String] {
        
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        return header
    }
    
    
}


extension APIExp {
    
    func taskGetResult(parameters:[String:Any]? = nil) -> Task {
        
        let dic = coverToDic()
        if dic.isEmpty {
            return .requestPlain
        } else {
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        }
    }
    
    func taskPostResult(parameters:[String:Any]? = nil) -> Task {
        
        let dic = coverToDic()
        if dic.isEmpty {
            return .requestPlain
        } else {
        return .requestParameters(parameters: dic, encoding: JSONEncoding.default)
        }
    }
    
    
    func coverToDic() -> Dictionary<String,Any> {
        
        var para : [String: Any] = [:]
        
        let mir = Mirror(reflecting: self)
        
        
        for (tkey,tval) in mir.children {
            let tupleMir =  Mirror(reflecting: tval)
            
//            if let _ = tupleMir.displayStyle {
            
                for (key,val) in tupleMir.children {
                    if let key = key {
                        
                        if let val1 = val as? String {
                            para[key] = val1
                        } else if let val1 = val as? Int {
                        print("--- parameter =  nil")
                            para[key] = val1
                        } else if let val1 = val as? TimeInterval {
                            para[key] = val1
                        } else {
//                        para[key] = val
                        }
                            
                    } else if let vkey = val as? String {
                        para[vkey] = vkey
                    }
                }
//            } else {
//                let val = tval
//                if let key = tkey {
//                    para[key] = val
//                } else if let vkey = val as? String {
//                    para[vkey] = val
//                }
//            }
            
        }
        
        return para
    }
    

}





//var userToken = ""
//var headerFields = ["TOKEN": userToken]

//let testAPIProvider = RxMoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub)
//let APIProvider = RxMoyaProvider<API>()
//let APIProvider = MoyaProvider<API>()
/*
enum API {
 // Example
// MARK: - 登录
   // case login(username: String, password: String)

}
*/
/*
extension API: JSONMappableTargetType {
    
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: "http://0.0.0.0:8080")!
        default:
            return URL(string: "https://0.0.0.0:8080")!
        }
}
    
    var path: String {
        switch self {
        case .login:
            return "/login/validateCredentials"
        }
        
        
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .login(let username,let password):
            return ["TOKEN":"\(username):\(password)"]
        case .userInfo:
            let token = UserDefaults.standard.string(forKey: 'key')
            SNLog(token)
            return ["X-AUTH-TOKEN":token ?? ""]
        default:
            return nil
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .get
        default:
            return .post
        }
        
    }
    
   
    
//    var sampleData: Data {
//        switch self {
//        case .user:
//            return stubbedResponseFromJSONFile(filename: "array_response")
//        default:
//            return "".data(using: .utf8)!
//        }
//    }
    
    // Then add an additional request method
    // Is not working:
    //func requestType<T:ALSwiftyJSONAble>(target: ExampleAPI) -> SignalProducer<T, Moya.Error> {
    //    return RCStubbedProvider.request(target).mapObject(target.responseType)
    //}
    // invalid
    var responseType: SNSwiftyJSONAble.Type {
        switch self {
        case .login:
            return SNNetModel.self
        default:
            return SNNetModel.self
        }
    }

    
    var task: Task {
        
        switch self {
        case .verfyRegisterSMS(let mobile), .verfyForgetPassSMS(let mobile),.verfyModifyPassSMS(let mobile),.activeMember(let mobile),.authPhoneCode(let mobile):
            let para = [
                "mobile" : mobile
            ]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)

        default:
            return Task.requestPlain
        }
        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
 
 */

/*
// 读取本地json文件
private func stubbedResponseFromJSONFile(filename: String, inDirectory subpath: String = "", bundle:Bundle = Bundle.main ) -> Data {
    guard let path = bundle.path(forResource: filename, ofType: "json", inDirectory: subpath) else { return Data() }

    if let dataString = try? String(contentsOfFile: path), let data = dataString.data(using: String.Encoding.utf8){
        return data
    } else {
        return Data()
    }
}
 
 */
