//
//  AppDelegate.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/10.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;
    var tabbarVC: MainTabbar?;
    
    //#MARK: -邢浩- 程序准备开始运行
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds);
        tabbarVC = MainTabbar();
        window?.rootViewController = tabbarVC;
        window?.makeKeyAndVisible();
        
        return true
    }
    
    //#MARK: -邢浩- 程序将要进入非活动状态 (比如:来电话)
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    //#MARK: -邢浩- 程序进入活动状态
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    //#MARK: -邢浩- 程序被推送到后台执行
    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }
    
    //#MARK: -邢浩- 程序从后台将要回到前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    //#MARK: -邢浩- 程序将要退出时
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    
}

