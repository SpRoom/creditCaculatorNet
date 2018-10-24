//
//  BGButton.swift
//  creditCaculatorNet
//
//  Created by spectator Mr.Z on 2018/10/22.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import UIKit

class BGButton: UIButton {

    let dl = UILabel().then {
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = color_main_blue_039fff
        
        addSubview(dl)
        
        dl.snp.makeConstraints { (make) in
            //            make.top.snEqualToSuperview().snOffset(26)
            //            make.centerX.snEqualToSuperview()
            make.center.snEqualToSuperview()
        }
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(content: String) {
        dl.text = content
        //        setTitle(content, for: .normal)
    }
    
}
