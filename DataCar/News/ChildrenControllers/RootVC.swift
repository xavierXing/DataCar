//
//  RootVC.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/11.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

enum refreshtype {
    case header,footer
}

class RootVC: UITableViewController {
    
    //#MARK: -邢浩- 控制器类型
    var TYPE_VC: vctype?
    var netWorkSource: Array<Any>?;
    var netWork_Link: String?;
    var json: AnyObject?;
    var jsonBlock:((_ source : AnyObject, _ RefreshType : refreshtype) -> ())?;
    
    //#MARK: -邢浩- link
    let netWorkLink_HTTP: String = "http://api.news18a.com/";//Http 请求前缀
    let network_HotVC: String = "init.php?m=ina_app&c=index&a=index_new";//热点 -> 无参数
    let network_VideoVC: String = "init.php?m=ina_app&c=vedio&a=focus";//视频 -> 无参数
    let network_LiveVC: String = "init.php?m=ina_app&c=vedio&a=new_live";//直播 -> 无参数
    let network_NewCarVC_Message: String = "init.php?m=ina_app&c=index&a=newcar";//新车_新车资讯 -> 无参数
    let network_Parameter: String = "init.php?m=ina_app&c=index&a=storylist";// xxx -> 有参数
    
    //#MARK: -邢浩- 网络加载控制器
    let XH_NetWork: XHNetWork = XHNetWork.shareInstance;
    
    //#MARK: -邢浩- 上拉默认页数
    var page: Int = 2;
    
    // ####################################   分割线   #######################################
    
    //#MARK: -邢浩- lazy loading
    lazy var netWorkError: NetWorkErrorView = {
        let netWorkError = NetWorkErrorView.init(frame: self.tableView.frame);
        return netWorkError;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeSureLink();
        self.configuration();
        self.netWorkSources();
    }
    
    private func configuration() -> Void {
        self.tableView.theme_backgroundColor = [backgroundLightColor,backgroundNightColor];
        self.tableView.frame = CGRect(x: 0, y: 0, width: XHScreenW, height: XHScreenH - 14);
        self.tableView.separatorColor = UIColor.clear;
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    private func netWorkSources() -> Void {
        self.tableView.mj_header = XHRefershHead(refreshingBlock: {
            self.loadingHeader();
        });
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadingFooter();
        });
        
        self.tableView.mj_header.beginRefreshing();
    }
    
    //#MARK: -邢浩- 头部刷新
    private func loadingHeader() -> Void {
        switch TYPE_VC! {
        case .HotVC,.VideoVC,.Live:
            self.loadingData();
        case .IndustryVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "industry" as AnyObject], RefreshType: .header);
        case .EvaluationVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "evaluation" as AnyObject], RefreshType: .header);
        case .ShoppingVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "guide" as AnyObject], RefreshType: .header);
        case .NewCarVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "newCar" as AnyObject], RefreshType: .header);//待修改
        case .UseCarVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "useCar" as AnyObject], RefreshType: .header);
        case .CultureVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "culture" as AnyObject], RefreshType: .header);
        case .TravelVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "travel" as AnyObject], RefreshType: .header);
        case .TechnologyVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "technology" as AnyObject], RefreshType: .header);
        case .PriceVC:
            self.loadingDataWithParameters(Parameters: ["storyType" : "market" as AnyObject], RefreshType: .header);
        }
    }
    
    //#MARK: -邢浩- 尾部刷新
    private func loadingFooter() -> Void {
        switch TYPE_VC! {
        case .HotVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject], RefreshType: .footer);
        case .VideoVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject], RefreshType: .footer);
        case .Live:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject], RefreshType: .footer);
        case .IndustryVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "industry" as AnyObject], RefreshType: .footer);
        case .EvaluationVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "evaluation" as AnyObject], RefreshType: .footer);
        case .ShoppingVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "guide" as AnyObject], RefreshType: .footer);
        case .NewCarVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "newCar" as AnyObject], RefreshType: .footer);
        case .UseCarVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "useCar" as AnyObject], RefreshType: .footer);
        case .CultureVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "culture" as AnyObject], RefreshType: .footer);
        case .TravelVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "travel" as AnyObject], RefreshType: .footer);
        case .TechnologyVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "technology" as AnyObject], RefreshType: .footer);
        case .PriceVC:
            self.loadingDataWithParameters(Parameters: ["page":page as AnyObject, "storyType" : "market" as AnyObject], RefreshType: .footer);
        }
    }
    
    private func makeSureLink() -> Void {
        switch TYPE_VC! {
        case .HotVC:
            netWork_Link = netWorkLink_HTTP + network_HotVC;
        case .VideoVC:
            netWork_Link = netWorkLink_HTTP + network_VideoVC;
        case .Live:
            netWork_Link = netWorkLink_HTTP + network_LiveVC;
        case .IndustryVC,.EvaluationVC,.ShoppingVC,.UseCarVC,.CultureVC,.TravelVC,.TechnologyVC,.PriceVC:
            netWork_Link = netWorkLink_HTTP + network_Parameter;
        case .NewCarVC://新车界面特殊:有两个控制器界面(类型 + 咨询)
            netWork_Link = netWorkLink_HTTP + network_NewCarVC_Message;
        }
    }
    
    func loadingData() -> Void {
        XH_NetWork.getRequest(urlString: netWork_Link!, success: { (response) in
            self.json = response as AnyObject;
            if self.jsonBlock != nil {
                self.jsonBlock!(self.json!,.header);
                
            }
        }) { (error) in
            self.tableView.addSubview(self.netWorkError);
            self.tableView.mj_header.endRefreshing();
        }
    }
    
    func loadingDataWithParameters(Parameters : [String: AnyObject], RefreshType : refreshtype) -> Void {
        XH_NetWork.getRequestWithParameters(urlString: netWork_Link!, params: Parameters, success: { (response) in
            
            self.json = response as AnyObject;
            if RefreshType == .footer {//尾部刷新才会更新page
                if self.jsonBlock != nil {
                    self.jsonBlock!(self.json!,.footer);
                }
                self.page += 1;
            } else {
                if self.jsonBlock != nil {
                    self.jsonBlock!(self.json!,.header);
                }
            }
            self.endRefreshLoad(reloadType: RefreshType);
            
        }) { (error) in
            self.tableView.addSubview(self.netWorkError);
            self.tableView.reloadData();
            self.endRefreshLoad(reloadType: RefreshType);
        }
    }
    
    func endRefreshLoad(reloadType: refreshtype) -> Void {
        if reloadType == .header {
            self.tableView.mj_header.endRefreshing();
        } else {
            self.tableView.mj_footer.endRefreshing();
        }
    }
    
}


