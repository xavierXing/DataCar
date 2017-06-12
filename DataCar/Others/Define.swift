//
//  Define.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/10.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import Foundation
import UIKit


//#MARK: -邢浩- 当前系统版本
let XHVersion = (UIDevice.current.systemVersion as NSString).floatValue

//#MARK: -邢浩- 屏幕宽度
let XHScreenW = UIScreen.main.bounds.width

//#MARK: -邢浩- 屏幕高度
let XHScreenH = UIScreen.main.bounds.height

//#MARK: -邢浩- 颜色方法
func RGBA (_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//#MARK: -邢浩- 不透明颜色
func RGBColor (_ r:CGFloat,g:CGFloat,b:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

//#MARK: -邢浩- IOS 8以上
func IS_IOS8() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }

//#MARK: -邢浩- 自定义Log;
func XLog<T>(message:T,file:String = #file,funcName:String = #function,lineNum:Int = #line){
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName)---->row\(lineNum)---->\(message)")
    #endif
}







































