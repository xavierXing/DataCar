//
//  HotVCModel.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/14.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotVCModel: NSObject {
    //#MARK: -邢浩- 热点新闻数据
}

class FocusModel: NSObject {
    var url: String?;
    var img: String?;
    var alt: String?;
    var type: String?;
    
    func build(json: JSON) -> FocusModel {
        let model = FocusModel();
        model.img = json["img"].string;
        model.alt = json["alt"].string;
        model.type = json["type"].string;
        model.url = json["url"].string;
        return model;
    }
    
}

class HotModel: NSObject {
    var id : String?;
    var title : String?;
    var shorttitle : String?;
    var title_pic1 : String?;
    var title_pic2 : String?;
    
    func build(json: JSON) -> HotModel {
        let model = HotModel();
        model.id = json["id"].string;
        model.title = json["json"].string;
        model.shorttitle = json["shorttitle"].string;
        model.title_pic1 = json["title_pic1"].string;
        model.title_pic2 = json["title_pic2"].string;
        return model;
    }
}

class HotNewsModel: NSObject {
    
    func build(json: JSON) -> HotNewsModel {
        let model = HotNewsModel();
        model.id = json["id"].string;
        model.title = json["title"].string;
        model.shorttitle = json["shorttitle"].string;
        model.author = json["author"].string;
        model.short_summary = json["short_summary"].string;
        model.title_pic1 = json["title_pic1"].string;
        model.title_pic2 = json["title_pic2"].string;
        model.story_date = json["story_date"].string;
        model.is_private = json["is_private"].string;
        model.url = json["url"].string;
        model.type = json["type"].string;
        model.publish_time = json["publish_time"].string;
        model.base_count = json["base_count"].string;
        model.time = json["time"].string;
        model.imgs = json["imgs"].array as? NSMutableArray;
        model.cellHight = json["cellHight"].float;
        
        return model;
    }
    
    var id : String?;
    var title : String?;
    var shorttitle : String?;
    var author : String?;
    var short_summary : String?;
    var title_pic1 : String?;
    var title_pic2 : String?;
    var story_date : String?;
    var is_private : String?;
    var url : String?;
    var type : String?;
    var publish_time : String?;
    var base_count : String?;
    var time : String?;
    var imgs : NSMutableArray?
    var cellHight : Float?;
}

class FourBtn: NSObject {
    var name : String?;
    var url : String?;
    var title_pic : String?;
    
    func build(json: JSON) -> FourBtn {
        let model = FourBtn();
        model.name = json["name"].string;
        model.url = json["url"].string;
        model.title_pic = json["title_pic"].string;
        return model;
    }
    
}


