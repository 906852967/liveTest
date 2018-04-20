//
//  PageTitleView.swift
//  DouYuAPP
//
//  Created by globalwings  on 2018/4/20.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit

class PageTitleView: UIView {

    private var titles : [String]
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
