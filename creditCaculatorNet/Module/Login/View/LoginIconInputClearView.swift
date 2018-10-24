//
//  LoginIconInputClearView.swift
//  changshoubao
//
//  Created by spectator Mr.Z on 2018/9/16.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class LoginIconInputClearView: SNBaseView {

    let iconV = UIImageView()
    
    let inputV = UITextField().then {
        $0.font = Font(36)
        $0.clearButtonMode = .whileEditing
    }
    

}

extension LoginIconInputClearView {
    
    override func setupView() {
        
        backgroundColor = color_gray_bg_f8f8f9
        layer.cornerRadius = fit(16)
        clipsToBounds = true
        
        addSubviews(views: [iconV,inputV])
        
        iconV.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.width.snEqualTo(64)
            make.height.snEqualTo(64)
            make.centerY.snEqualToSuperview()
        }
        
        inputV.snp.makeConstraints { (make) in
            make.top.snEqualToSuperview()
            make.bottom.snEqualToSuperview()
            make.left.snEqualTo(iconV.snp.right).snOffset(20)
            make.right.snEqualToSuperview().snOffset(-30)
        }
//        iconV.snap(top: nil, bottom: nil, left: .leftNum(30), right: nil, center: nil, centerX: nil, centerY: .centerY, width: .num(64), height: .num(64))
//        inputV.snap(top: .top, bottom: .bottom, left: .leftNumFor(iconV.snp.right,20), right: .rightNum(-30), center: nil, centerX: nil, centerY: nil, width: nil, height: nil)
    }
    
    func set(icon: String, place: String) {
        self.iconV.image = Image(icon)
        self.inputV.placeholder = place
        
    }
}
