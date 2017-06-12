//
//  NewsVC.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/10.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit


class NewsVC: UIViewController,UIScrollViewDelegate {
    
    let selectedFont: String = "Helvetica-Bold";
    var selectedBtn: UIButton?;
    
    //#MARK: -邢浩- lazy loading
    lazy var scrollView: UIScrollView? = {
        let scroll = UIScrollView(frame: self.view.frame);
        scroll.delegate = self;
        scroll.isPagingEnabled = true;
        scroll.contentSize = CGSize(width: scroll.frame.width * 12, height: 0);//12代表子控制器数量
        scroll.theme_backgroundColor = [backgroundLightColor,backgroundNightColor];
        scroll.showsHorizontalScrollIndicator = false;
        return scroll;
    }();
    
    lazy var scrollTitle: UIScrollView? = {
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 7, width: (XHScreenW - XHScreenW * 0.145 - 10), height: 30));
        scrollView.contentSize = CGSize(width: XHScreenW * 0.12 * 12, height: 0);//12代表子控制器数量
        scrollView.showsHorizontalScrollIndicator = false;
        return scrollView;
    }()
    
    lazy var searchBtn: UIButton? = {
        let search = UIButton(type: UIButtonType.custom);
        search.frame = CGRect(x: XHScreenW - XHScreenW * 0.145, y: 0, width: XHScreenW * 0.145, height: CGFloat((self.navigationController?.navigationBar.frame.size.height)!
))
        search.setImage(UIImage(named: "search_btn"), for: .normal);
        search.setTitleColor(UIColor.rgbColor(r: 246, g: 50, b: 51), for: .normal);
        search.addTarget(withBlock: { (_) in
            //跳转到搜索界面
            let searchVC: SearchVC = SearchVC();
            searchVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(searchVC, animated: true);

        })
        
        return search;
    }()
    
    
    //#MARK: -邢浩- overide
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true);
        self.navigationController?.navigationBar.theme_barTintColor = [tabBarLightColor,tabBarNightColor];
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingContoller();
        
    }
    
    //#MARK: -邢浩- private Method
    private func settingContoller() -> Void {
        self.view.addSubview(self.scrollView!);
        self.makeNavgaitonBar()
        self.makeButtonControls();
        self.makeControllersControls();
        self.scrollViewDidEndScrollingAnimation(self.scrollView!);
    }
    
    private func makeNavgaitonBar() -> Void {
        let bg_View = UIView.init(frame: (self.navigationController?.navigationBar.frame)!);
        bg_View.addSubview(self.scrollTitle!);
        bg_View.addSubview(self.searchBtn!);
        self.navigationItem.titleView = bg_View;
        
    }
    
    private func makeButtonControls() -> Void {
        let btn_width = XHScreenW * 0.12;
        let btn_titles = ["热点", "视频","直播", "行业", "评测", "导购", "新车", "用车", "文化", "游记", "技术", "行情"];
        for i in 0..<btn_titles.count {
            let btn = UIButton(frame: CGRect(x: btn_width * CGFloat(i), y: 0, width: btn_width, height: (self.scrollTitle?.frame.height)!));
            btn.tag = i;
            btn.setTitle(btn_titles[i], for: .normal);
            btn.setTitleColor(UIColor.white, for: .normal);
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14);
            btn.titleLabel?.textAlignment = .left;
            btn.addTarget(withBlock: { (_) in
                
            })
            self.scrollTitle?.addSubview(btn);
            if btn.tag == 0 {
                btn.isEnabled = false;
                btn.titleLabel?.font = UIFont.init(name: selectedFont, size: 17);
                self.selectedBtn = btn;
            }
        }
    }
    
    private func makeControllersControls() -> Void {
        let vcArr: Array = ["HotVC","VideoVC","Live","IndustryVC","EvaluationVC","ShoppingVC","NewCarVC","UseCarVC","CultureVC","TravelVC","TechnologyVC","PriceVC"];
        guard let clsName = Bundle.main.infoDictionary?["CFBundleExecutable"] else {
            XLog(message: "命名空间不存在...");
            return;
        };
        for i in 0..<vcArr.count {
            guard let cls : AnyClass = NSClassFromString((clsName as! String) + "." + vcArr[i]) else {
                return;
            }
            guard let clsType = cls as? RootVC.Type else {
                return;
            }
            
            let childrenVC = clsType.init();
            self.addChildViewController(childrenVC);
        };
    }
    
    func titleBtnClick(btn: UIButton) -> Void {
        self.selectedBtn?.isEnabled = true;
        self.selectedBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        btn.isEnabled = false;
        btn.titleLabel?.font = UIFont.init(name: selectedFont, size: 17);
        self.selectedBtn = btn;
        var offset: CGPoint = (self.scrollView?.contentOffset)!;
        offset.x = CGFloat(btn.tag) * (self.scrollView?.frame.size.width)!;
        
        if CGFloat(btn.tag) * XHScreenW * 0.12 > (self.scrollTitle?.frame.size.width)! {
            var offset: CGPoint = (self.scrollTitle?.contentOffset)!;
            offset.x = (self.scrollTitle?.contentSize.width)! - (self.scrollTitle?.frame.size.width)!;
            self.scrollTitle?.setContentOffset(offset, animated: true);
        } else {
            var offset: CGPoint = (self.scrollTitle?.contentOffset)!;
            offset.x = 0;
            self.scrollTitle?.setContentOffset(offset, animated: true);
        }
        self.scrollView?.setContentOffset(offset, animated: true);
    }
    

}

//#MARK: -邢浩- scroll Delegate
extension NewsVC {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        guard let vc: UITableViewController = self.childViewControllers[index] as? UITableViewController else {
            return
        }
        
        vc.view.frame.origin.x = scrollView.contentOffset.x;
        vc.view.frame.origin.y = 0;
        vc.view.frame.size.height = scrollView.frame.size.height;
        if index != 6 {
            let bottom: CGFloat = (self.tabBarController?.tabBar.frame.size.height)!;
            vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottom + 64, 0);
            vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
            scrollView.addSubview(vc.view);
        } else {
            scrollView.addSubview(vc.view);
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView);
        let index: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
        guard let btn_click: UIButton = self.scrollTitle?.subviews[index + 1] as? UIButton else {
            return;
        }
        self.titleBtnClick(btn: btn_click);
    }
}





