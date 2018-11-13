//
//  UIView_Extension.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/6.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import SNSwiftPackage

extension UIView {
    @discardableResult
    func setGradient(colors: [UIColor], startPoint: CGPoint ,endPoint: CGPoint) -> CAGradientLayer? {
        func setGradient(_ layer: CAGradientLayer) {
            self.layoutIfNeeded()
            var colorArr = [CGColor]()
            for color in colors {
                colorArr.append(color.cgColor)
            }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.frame = self.bounds
            CATransaction.commit()
            
            layer.colors = colorArr
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
        
        let gradientLayer = CAGradientLayer()
        self.layer.insertSublayer(gradientLayer , at: 0)
        setGradient(gradientLayer)
//        objc_setAssociatedObject(self, &gradientLayerStr, gradientLayer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return gradientLayer
        
        
//        if let gradientLayer = objc_getAssociatedObject(self, &gradientLayer) as? CAGradientLayer {
//            setGradient(gradientLayer)
//            return gradientLayer
//        }else {
//            let gradientLayer = CAGradientLayer()
//            self.layer.insertSublayer(gradientLayer , at: 0)
//            setGradient(gradientLayer)
//            objc_setAssociatedObject(self, &gradientLayer, gradientLayer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return gradientLayer
//        }
    }
}
