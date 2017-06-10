//
//  MainTabbar.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/10.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit

class MainTabbar: UITabBarController {
    
    //#MARK: -邢浩- TabbarItem
    let News: String = "NewsVC";
    let News_Title: String = "要闻";
    let News_Icon: String = "news_normal_icon";
    
    let Choiceness: String = "ChoicenessVC";
    let Choiceness_Title: String = "精选";
    let Choicenes_Icon: String = "choice_normal_icon";

    
    let ChooseCar: String = "ChooseCarVC";
    let Choose_Title: String = "选车";
    let ChooseCar_Icon: String = "choosecar_normal_icon";

    let Acivity: String = "ActivityVC";
    let Acivity_Title = "活动";
    let Acivity_Icon: String = "activity_normal_icon";

    let Setting: String = "SettingVC";
    let Setting_Title = "我的"
    let Setting_Icon: String = "person_normal_icon";

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildren();
    }
    
    //#MARK: -邢浩- 反射机制 & 命名空间
    private func addChildren() -> Void {
        addChildVC(childVCName: News, title: News_Title, normalImg: News_Icon);
        addChildVC(childVCName: Choiceness, title: Choiceness_Title, normalImg: Choicenes_Icon);
        addChildVC(childVCName: ChooseCar, title: Choose_Title, normalImg: ChooseCar_Icon);
        addChildVC(childVCName: Acivity, title: Acivity_Title, normalImg: Acivity_Icon);
        addChildVC(childVCName: Setting, title: Setting_Title, normalImg: Setting_Icon);
        self.tabBar.tintColor = UIColor.red;
    }
    
    private func addChildVC(childVCName:String ,title: String, normalImg: String ) -> Void {
        guard let clsName = Bundle.main.infoDictionary?["CFBundleExecutable"] else {
            XLog(message: "命名空间不存在...");
            return;
        };
        
        let cls: AnyClass? = NSClassFromString((clsName as! String) + "." + childVCName);
        
        guard let clsType = cls as? UIViewController.Type  else {
            XLog(message: "类型不匹配...");
            return;
        }
        
        let childController = clsType.init();
        
        childController.title = title;
        childController.tabBarItem.image = UIImage(named: normalImg)?.withRenderingMode(.alwaysOriginal);
        childController.tabBarItem.selectedImage = UIImage(named: normalImg.replacingOccurrences(of: "normal", with: "selected"))?.withRenderingMode(.alwaysOriginal);
        let nav = UINavigationController(rootViewController: childController);
        self.addChildViewController(nav);
        
    }
    
}
