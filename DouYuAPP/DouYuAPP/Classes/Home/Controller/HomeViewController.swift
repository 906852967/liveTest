//
//  HomeViewController.swift
//  DouYuAPP
//
//  Created by globalwings  on 2018/4/19.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
//设置UI
extension HomeViewController {
    private func setupUI(){
        //1.设置导航栏
        setupNavigationBar()
    }
    private func setupNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
    
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let searchBtnItem = UIBarButtonItem(imageName: "anchor_music_search_input_search_icon", highImageName: "anchor_music_search_input_search_icon", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchBtnItem, qrcodeItem]
    }
}
