//
//  XHRefershHead.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/13.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit
import MJRefresh

class XHRefershHead: MJRefreshGifHeader {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.loadingAnimation();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.loadingAnimation();
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadingAnimation() -> Void {
        let normalImg_Array: NSMutableArray = NSMutableArray();
        let refreshImg_Array: NSMutableArray = NSMutableArray();
        
        let normalImg: UIImage = UIImage.init(named: "wts_loading_img1")!;
        normalImg_Array.add(normalImg);
        
        for i in 0..<13 {
            let refreshImg: UIImage = UIImage.init(named: "wts_loading_img" + String(i + 1))!;
            refreshImg_Array.add(refreshImg);
        }
        
        self.setImages(normalImg_Array as! [Any], for: .idle);
        self.setImages(refreshImg_Array as! [Any], for: .refreshing);
        self.setImages(refreshImg_Array as! [Any], for: .pulling);
        self.lastUpdatedTimeLabel.isHidden = true;
        self.stateLabel.isHidden = true;
        
        
    }
    
}
