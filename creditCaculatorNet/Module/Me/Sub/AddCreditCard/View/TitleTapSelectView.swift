//
//  TitleTapSelectView.swift
//  changshoubao
//
//  Created by spectator Mr.Z on 2018/9/22.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import UIKit
import SNSwiftPackage

class TitleTapSelectView: SNBaseView {

    let nameL = UILabel().then {
        $0.font = Font(36)
        $0.textColor = color_black_717580
    }
    let detailL = UILabel().then {
        $0.font = Font(32)
        $0.textColor = color_black_717580
        $0.adjustsFontSizeToFitWidth = true
        $0.isUserInteractionEnabled = true
    }
    let accessoryV = UIImageView().then {
        $0.image = Image("accessory")
    }

}

extension TitleTapSelectView {
    
    override func setupView() {
        
        addSubviews(views: [nameL,detailL,accessoryV])
        
        nameL.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().snOffset(30)
            make.centerY.snEqualToSuperview()
        }
    
        detailL.snp.makeConstraints { (make) in
            make.top.snEqualToSuperview()
            make.bottom.snEqualToSuperview()
            make.left.snEqualToSuperview().snOffset(270)
            make.right.snEqualToSuperview().snOffset(10)
        }
        accessoryV.snp.makeConstraints { (make) in
            make.right.snEqualToSuperview().snOffset(-30)
            make.centerY.snEqualToSuperview()
        }
        
    }
    
    func set(title: String, detail: String = "", isAc: Bool = true) {
        self.nameL.text = title
        self.detailL.text = detail
        self.accessoryV.isHidden = !isAc
    }
    
    func set(detail: String) {
        self.detailL.text = detail
    }
    
}
