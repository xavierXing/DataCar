//
//  HotVC.swift
//  DataCar
//
//  Created by LeoTai on 17/6/12.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit
import SwiftyJSON
class HotVC: RootVC {
    
    //#MARK: -邢浩- lazy loading
    lazy var ad_Data: NSMutableArray = {
        let Arr = NSMutableArray();
        return Arr;
    }()
    
    lazy var focus_Data: NSMutableArray = {
        let Arr = NSMutableArray();
        return Arr;
    }()
    
    lazy var hot_Data: NSMutableArray = {
        let Arr = NSMutableArray();
        return Arr;
    }()
    
    lazy var news_Data: NSMutableArray = {
        let Arr = NSMutableArray();
        return Arr;
    }()
    
    lazy var fourBtn_Data: NSMutableArray = {
        let Arr = NSMutableArray();
        return Arr;
    }()
    
    
    lazy var focusModel: FocusModel = {
        let model = FocusModel();
        return model;
    }()
    
    lazy var hotModel: HotModel = {
        let model = HotModel();
        return model;
    }()
    
    lazy var hotNewsModel: HotNewsModel = {
        let model = HotNewsModel();
        return model;
    }()
    
    lazy var fourBtnModel: FourBtn = {
        let model = FourBtn();
        return model;
    }()
    
    //#MARK: -邢浩- override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration();
        self.getNetWorkSource();
        
    }
    
    //#MARK: -邢浩- paivate Method
    private func configuration() -> Void {
        self.navigationController?.navigationBar.isTranslucent = false;
        self.view.theme_backgroundColor = [backgroundLightColor,backgroundNightColor];
    }
    
    private func getNetWorkSource() -> Void {
        //下拉加载
        self.jsonBlock = { json, refreshTyoe in
            //解析-- 头部刷新
            if refreshTyoe == .header {
                let ad = JSON(json)["data"]["first_ad"];
                let focus = JSON(json)["data"]["focus"];
                let topNewsData = JSON(json)["data"]["topNewsData"];
                let hotNewsData = JSON(json)["data"]["hotNewsData"];
                let fourBtnData = JSON(json)["data"]["four_button"];
                //转换模型--
                self.focusModel = self.focusModel.build(json: ad);
                for i in 0..<focus.count {
                    var model = FocusModel();
                    model = model.build(json: focus[i]);
                    self.focus_Data.add(model);
                }
                
                for i in 0..<topNewsData.count {
                    var model = HotModel();
                    model = model.build(json: topNewsData[i]);
                    self.hot_Data.add(model);
                }
                
                for i in 0..<hotNewsData.count {
                    var model = HotNewsModel();
                    model = model.build(json: hotNewsData[i]);
                    self.news_Data.add(model);
                }
                
                for i in 0..<fourBtnData.count {
                    var model = FourBtn();
                    model = model.build(json: fourBtnData[i]);
                    self.fourBtn_Data.add(model);
                }
                
            } else {//解析-- 尾部刷新
                let hotNewsData = JSON(json)["data"]["hotNewsData"];
                for i in 0..<hotNewsData.count {
                    var model = HotNewsModel();
                    model = model.build(json: hotNewsData[i]);
                    self.news_Data.add(model);
                }
                
            }
            
            XLog(message: "\(self.focus_Data)");
            XLog(message: "\(self.hot_Data)");
            XLog(message: "\(self.news_Data)");
            XLog(message: "\(self.fourBtn_Data)");
            
        }
    }
    
}

































