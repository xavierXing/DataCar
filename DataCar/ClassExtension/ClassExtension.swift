//
//  ClassExtension.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/10.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import Foundation
import UIKit
//#MARK: -邢浩- 16进制颜色转换RGB
extension UIColor {
    static func hexColor(hex: Int32) -> UIColor {
        let r = CGFloat((hex & 0xFF0000) >> 16)
        let g = CGFloat((hex & 0x00FF00) >> 8)
        let b = CGFloat((hex & 0x0000FF) >> 0)
        
        return UIColor.rgbColor(r: r, g: g, b: b)
    }
    
    static func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(
            red: CGFloat(r/255.0),
            green: CGFloat(g/255.0),
            blue: CGFloat(b/255.0)
            , alpha: 1.0)
    }
}

extension UIColor {
    
    class func rgbaColorFromHex(rgb:Int, alpha: CGFloat) ->UIColor {
        
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: alpha)
    }
    
    class func rgbColorFromHex(rgb:Int) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
}

extension UIColor {
    
    static func colorWithHexString(hex: String) -> UIColor {
        
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if cString.characters.count != 6 {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}

//#MARK: -邢浩- 16进制颜色转换
func XHRGBColorFromHex(rgbValue: Int) -> UIColor {
    return UIColor(red: (CGFloat((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: (CGFloat((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: (CGFloat(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
    
}

//#MARK: -邢浩- 响应式UIButton
extension UIButton {
    
    typealias newDataBlock = (Any) -> Void
    
    // 关联属性的key
    private struct associatedKeys {
        static var newDataBlockKey = "GestureBlockKey"
    }
    
    fileprivate class BlockContainer: NSObject, NSCopying {
        var newDataBlock: newDataBlock?
        func copy(with zone: NSZone? = nil) -> Any {
            return self
        }
    }
    
    // fileprivate: 文件内作用域 为了让上面能用
    fileprivate var blockm: BlockContainer? {
        get {
            if let newDataBlock = objc_getAssociatedObject(self, &associatedKeys.newDataBlockKey) as? BlockContainer {
                return newDataBlock
            }
            return nil
        }
        set(newValue) {
            objc_setAssociatedObject(self, &associatedKeys.newDataBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func addTarget(for controlEvents: UIControlEvents = .touchUpInside, withBlock block: @escaping newDataBlock) {
        self.blockm = blockm ?? BlockContainer()
        blockm?.newDataBlock = block
        self.addTarget(self, action: #selector(self.callback(sender:)), for: controlEvents)
    }
    
    func callback(sender: UIButton) {
        self.blockm?.newDataBlock?(sender)
    }
    
}
