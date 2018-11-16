//
//  Const.swift
//  creditCalculator
//
//  Created by spectator Mr.Z on 2018/10/6.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SNSwiftPackage

let baseUrl = "http://creditcacu.speczhu.tk:8001"

let color_black_717580 = Color(0x717580)
let color_gray_ccc = Color(0xcccccc)
let color_gray_bg_f8f8f9 = Color(0xf8f8f9)
let color_main_blue_039fff = Color(0x039fff)


// rxswift
func <= <T>(lhs: BehaviorSubject<T>, rhs: T) {
    
    lhs.onNext(rhs)
}

func <= <T>(lhs: BehaviorRelay<T>, rhs: T) {
    
    lhs.accept(rhs)
}


func dateFor(string: String, format: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(identifier: "PRC")
//    dateFormatter.timeZone = TimeZone(identifier: "GMT")
    dateFormatter.locale = Locale.init(identifier: "zh_CN")
    let date = dateFormatter.date(from: string)
    return date ?? nil
    
}

func dateFor(date: Date, format: String) -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    let str = formatter.string(from: date)
    
    return str
}


func getDateStrMMlinedd(timeInterval: TimeInterval) -> String {
    
    return getTimeBy(timeStamp: "\(timeInterval)", format: "MM-dd")
    
}

func pointToYuan(value: Int) -> String {
    
    return String(format: "%.2f", Float(value)/100)
}

func yuanToPoint(value: String) -> Int {
    
    let d = Double(value) ?? 0
    let i = Int(d * 100)
    
    return i
}
