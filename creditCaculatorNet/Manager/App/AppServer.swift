//
//  AppServer.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage
import IQKeyboardManager

extension AppDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApp()
        
        configAPIManager()
        
        configKeyboardManager()
       
        
        return true
    }
    
    
    func startApp() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        if let userDecoded = UserDefaults.standard.value(forKey: "token") as? Data {
            if #available(iOS 12.0, *) {
                // ide tip error, not found solution
//                let token = try! NSKeyedUnarchiver.unarchivedObject(ofClass: String.self, from: userDecoded)
                let token = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userDecoded) as! String
                Singleton.shared.token = token
            } else {
            let token = NSKeyedUnarchiver.unarchiveObject(with: userDecoded) as! String
//            let token = try! NSKeyedUnarchiver.unarchivedObject(ofClass: String.self, from: userDecoded)
//            c
            Singleton.shared.token = token
            }
            window?.rootViewController = SNMainTabBarController.shared
            
        } else {
            // 跳登陆
            window?.rootViewController = LoginViewController()
            
        }
        
        window?.makeKeyAndVisible()
    }
    
    func configAPIManager() {
        
        SNAPIConfig.configResultKey(status: "1000")
        
       
    }
    
    func configKeyboardManager() {
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
    
    
    
}
