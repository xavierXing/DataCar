//
//  NetWorkErrorView.swift
//  DataCar
//
//  Created by 邢浩 on 2017/6/13.
//  Copyright © 2017年 邢浩. All rights reserved.
//

import UIKit

class NetWorkErrorView: UIView {
    
    let netWorkerror_LabText: String = "网络出错了,请点击按钮重新加载";
    let netWorkerror_BtnText: String = "重新加载";
    
    var netWorkError_Img: UIImageView?;
    var reloadBtn: UIButton?;
    var netWorkError_lab: UILabel?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.configuration();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.configuration();
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() -> Void {
        self.theme_backgroundColor = [backgroundLightColor,backgroundNightColor];
        self.settingControls();
        self.settingLayout();
    }
    
    private func settingControls() -> Void {
        netWorkError_Img = UIImageView.init(image: UIImage.init(named: "networkerror_img"));
        self.addSubview(netWorkError_Img!);
        
        netWorkError_lab = UILabel();
        netWorkError_lab?.theme_textColor = [textLightColor,textNightColor];
        netWorkError_lab?.font = UIFont.systemFont(ofSize: 17);
        netWorkError_lab?.text = netWorkerror_LabText;
        netWorkError_lab?.textAlignment = .center;
        self.addSubview(netWorkError_lab!);
        
        reloadBtn = UIButton.init(type: .custom);
        reloadBtn?.setTitle(netWorkerror_BtnText, for: .normal);
        reloadBtn?.setTitleColor(UIColor.colorWithHexString(hex: "#616161"), for: .normal);
        reloadBtn?.setBackgroundImage(UIImage.init(named: "neterror_boc_btn"), for: .normal);
        self.addSubview(reloadBtn!);
        
    }
    
    private func settingLayout() -> Void {
        let line: CGFloat = XHScreenW * 0.031;
        
        netWorkError_Img?.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(line * 20);
            make.height.equalTo(line * 15);
            make.top.equalTo(self.snp.top).offset(line * 8);
            make.centerX.equalTo(self.snp.centerX);
        })
        
        netWorkError_lab?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((netWorkError_Img?.snp.bottom)!).offset(line * 2);
            make.left.equalTo(self.snp.left).offset(line);
            make.right.equalTo(self.snp.right).offset(-line);
            make.height.equalTo(line * 3);
            make.centerX.equalTo(self.snp.centerX);
        })
        
        reloadBtn?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo((netWorkError_lab?.snp.bottom)!).offset(line * 2);
            make.width.equalTo(line * 20);
            make.height.equalTo(line * 4);
            make.centerX.equalTo(self.snp.centerX);
        })
        
    }
    
}
