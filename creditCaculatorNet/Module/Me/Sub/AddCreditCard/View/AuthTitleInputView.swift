//
//  AuthTitleInputView.swift
//  changshoubao
//
//  Created by spectator Mr.Z on 2018/9/22.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class AuthTitleInputView: SNBaseView {

    let titleL = UILabel().then {
        $0.font = Font(36)
        $0.textColor = color_black_717580
    }
    
    let fieldV = UITextField().then {
        $0.font = Font(32)
        $0.layer.borderColor = color_gray_ccc.cgColor
        $0.layer.borderWidth = 1
        let left = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        $0.leftView = left
        $0.leftViewMode = .always
    }

    
}


extension AuthTitleInputView {
    
    override func setupView() {
        
        addSubviews(views: [titleL,fieldV])
        
        
        titleL.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(44)
            make.centerY.snEqualToSuperview()
        }
        
        
        fieldV.snp.makeConstraints { (make) in
            make.top.snEqualToSuperview().snOffset(20)
            make.bottom.snEqualToSuperview().snOffset(-20)
            make.left.snEqualToSuperview().snOffset(270)
            make.right.snEqualToSuperview().snOffset(-30)
        }
        
        let line = UIView().then {
            $0.backgroundColor = color_gray_bg_f8f8f9
        }
        
        addSubview(line)
//        line.snp(bottom: .bottom, left: .leftNum(40), right: .rightNum(-40), height: .num(2))
        line.snp.makeConstraints { (make) in
            make.bottom.snEqualToSuperview()
            make.left.snEqualToSuperview().snOffset(40)
            make.right.snEqualToSuperview().snOffset(-40)
            make.height.snEqualTo(2)
        }
        
    }
    
    func set(title: String, placeholder: String) {
        
        self.titleL.text = title
        self.fieldV.placeholder = placeholder
    }
}
