//
//  NewsVC.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/10.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit

class NewsVC: UIViewController,UIScrollViewDelegate {
    
    //#MARK: -邢浩- lazy loading
    lazy var scrollView: UIScrollView? = {
        let scroll = UIScrollView(frame: self.view.frame);
        scroll.delegate = self;
        scroll.isPagingEnabled = true;
        scroll.contentSize = CGSize(width: scroll.frame.width * CGFloat(self.childViewControllers.count), height: 0);
        scroll.backgroundColor = UIColor.colorWithHexString(hex: "#eeeeee");
        return scroll;
    }();
    
    lazy var scrollTitle: UIScrollView? = {
        let srollView = UIScrollView(frame: CGRect(x: 10, y: 0, width: (XHScreenW - XHScreenW * 0.145 - 10), height: 30));
        srollView.contentSize = CGSize(width: XHScreenW * CGFloat(self.childViewControllers.count), height: 0);
        srollView.showsHorizontalScrollIndicator = false;
        return srollView;
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.shared.statusBarStyle = .lightContent;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingContoller();
    }
    
    //#MARK: -邢浩- private Method
    private func settingContoller() -> Void {
        self.view.addSubview(self.scrollView!);
        self.navigationItem.titleView = self.scrollTitle;
        
    }
    
    func makeControls() -> Void {
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
                XLog(message: "11111");
            })
            
        }
    }
    
}
