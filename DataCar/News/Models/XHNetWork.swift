//
//  XHNetWork.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/13.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

//#MARK: -邢浩- singleton
private let NetworkRequestShareInstance = XHNetWork();
class XHNetWork: NSObject {
    class var shareInstance: XHNetWork {
        return NetworkRequestShareInstance;
    }
}
//#MARK: -邢浩- 封装 Alamofire
extension XHNetWork {
    
    //无参数
    public func getRequest(urlString: String, success: @escaping (_ response : [String: AnyObject]) -> (), failture: @escaping (_ error: Error) ->()) -> Void {
        Alamofire.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let value = response.result.value as? [String : AnyObject] {
                    success(value);
                }
                let json = JSON(value);
                XLog(message: json);
            case .failure(let error):
                failture(error);
            }
        }
    }
    
    //有参数
   public func getRequestWithParameters(urlString: String, params: [String: Any], success: @escaping (_ response : [String: AnyObject]) -> (), failture: @escaping (_ error : Error) -> ()) -> Void {
        Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value) :
                if let value = response.result.value as? [String : AnyObject] {
                    success(value);
                }
                let json = JSON(value);
                XLog(message: json);
            case .failure(let error) :
                failture(error);
            }
        }
        
    }
}

