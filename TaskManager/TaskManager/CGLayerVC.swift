//
//  CGLayerVC.swift
//  TaskManager
//
//  Created by globalwings  on 2018/11/12.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit
class CGLayerVC: UIViewController {
    let drawLayer = ALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.layer.addSublayer(drawLayer)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CGLayerTest()
        //允许layer进行绘制
        drawLayer.setNeedsDisplay()
    }
}
extension CGLayerVC{
    func CGLayerTest(){
        let wh = view.frame.width - 40
        drawLayer.frame = CGRect(x: 20, y: 20, width: wh, height: wh)
        drawLayer.borderColor = UIColor.cyan.cgColor
        drawLayer.borderWidth = 5
//        drawLayer.delegate = self
        
        drawLayer.contentsScale = UIScreen.main.scale
    }
//    func draw(_ layer: CALayer, in ctx: CGContext) {
//        //画笔颜色 (线)
//        ctx.setStrokeColor(UIColor.red.cgColor)
//        ctx.setLineWidth(2)
//        ctx.addEllipse(in: CGRect(x: 30, y: 30, width: 150, height: 150))
//        ctx.strokePath() //绘制渲染
//    }
}
//1. 创建一个CALayer的子类
class ALayer: CALayer {
    //2. 子类重写 draw方法, 进行绘制操作
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(UIColor.yellow.cgColor) //画笔颜色 (y填充)
        ctx.addEllipse(in: CGRect(x: 30, y: 30, width: 150, height: 150))
        ctx.fillPath()  //绘制渲染(填充)
        
    }
}
