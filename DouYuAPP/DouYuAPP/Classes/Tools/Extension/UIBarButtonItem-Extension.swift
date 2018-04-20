//
//  UIBarButtonItem-Extension.swift
//  DouYuAPP
//
//  Created by globalwings  on 2018/4/20.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit
extension   UIBarButtonItem{
//    class func creatItem(imageName: String, highImageName : String, size : CGSize) -> UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    //便利构造函数 1>convenience开头 2>在构造函数种必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, highImageName : String = "", size : CGSize = CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != ""{
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
