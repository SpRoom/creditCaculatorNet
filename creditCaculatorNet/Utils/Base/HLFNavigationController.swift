//
//  HLFNavigationController.swift
//  pocs
//
//  Created by spectator Mr.Z on 2018/6/29.
//  Copyright © 2018年 haolefu. All rights reserved.
//

import UIKit

class HLFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}



extension HLFNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count >= 1 {
            
//            let button = UIButton()
//            button.setImage(UIImage(named:"back"), for: .normal)
//            //            button.sizeToFit()
//            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
//            button.addTarget(self, action: #selector(backUp), for: .touchUpInside)
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            
            viewController.hidesBottomBarWhenPushed = true
        }
//        else {
//            viewController.navigationController?.isNavigationBarHidden = true
//        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func backUp(){
        
        //        if DDZSingleton.shared.isBackToHome == .popToHome {
        ////            popToRootViewController(animated: false)
        ////            self.viewControllers[0].tabBarController?.tabBar.isHidden = false
        //            self.viewControllers[0].tabBarController?.selectedIndex = 0
        //            DDZSingleton.shared.isBackToHome = .pop
        //            popToRootViewController(animated: true)
        //        } else {
        //        let _ = popViewController(animated: true)
        //        }
        
        if hlfnavitoroot {
            let _ = popToRootViewController(animated: true)
            hlfnavitoroot = false
        } else {
        let _ = popViewController(animated: true)
        }
    }
}

var hlfnavitoroot = false
