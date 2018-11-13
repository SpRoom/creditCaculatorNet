//
//  SNMainTabBarController.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/12.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift
import SNSwiftPackage

class SNMainTabBarController: UITabBarController {
    
    static let shared = SNMainTabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

fileprivate extension SNMainTabBarController {
    
    func setup() {
        
//        let home = navi(ZPHHomeViewController(), title: "首页", image: "home_homepage", selectedImage: "home_homepage1")
        let home = navi(RemindViewController(), title: "首页", image: "home1", selectedImage: "home2")
        let consumption = navi(ConsumptionViewController(), title: "消费", image: "", selectedImage: "")
        
        let me = navi(MeViewController(), title: "我的", image: "me1", selectedImage: "me2")

        self.viewControllers = [home,consumption, me]
        
        self.delegate = self
    }
    
    func customTabbarItem(title: String?, image: String?, selectedImage: String?) -> UITabBarItem {
        
        let bar = UITabBarItem()
        
        if let t = title {
            bar.title = t
        }
        
        if let img = image {
            bar.image = Image(img)
        }
        
        if let simg = selectedImage {
            bar.selectedImage = Image(simg)
        }
        

        return bar
    }
    
    func navi(_ vClass: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        
        vClass.tabBarItem = customTabbarItem(title: nil, image: image, selectedImage: selectedImage)
        vClass.title = title
        
        let selAttr = [
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        let defAttr = [
            NSAttributedString.Key.foregroundColor : UIColor.gray  //Color(0x413d3c)
        ]
        
        vClass.tabBarItem.setTitleTextAttributes(defAttr, for: .normal)
        vClass.tabBarItem.setTitleTextAttributes(selAttr, for: .selected)
        
        let navi = HLFNavigationController(rootViewController: vClass)

        navi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : Font(42)]
        return navi
    }
}


extension SNMainTabBarController : UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex != 0 {
//            ZPHSingleton.shared.updatetUserInfo()
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        SNLog(tabBarController.selectedIndex)
//             let user = ZPHSingleton.shared.userInfoVari.value
//        
//
//        if viewController.tabBarItem.title == "我" || viewController.tabBarItem.title == "购物车" {
//            
//        if user.mobile == "" {
//            let c = getCurrentVC()
//            let nvc = c.childViewControllers[0] as? UINavigationController
//            nvc?.pushViewController(DDZLoginViewController(), animated: true)
//            
//            return false
//        } else {
//            return true
//        }
//        } else {
//            return true
//        }
        
        return true
              
    }
}
