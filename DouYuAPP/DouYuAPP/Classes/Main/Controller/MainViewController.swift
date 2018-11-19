//
//  MainViewController.swift
//  DouYuAPP
//
//  Created by globalwings  on 2018/4/18.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit
import Alamofire
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
    }
    private func addChildVC(_ storyName : String){
        //获取sb
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
