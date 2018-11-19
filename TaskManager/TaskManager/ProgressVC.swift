//
//  ProgressVC.swift
//  TaskManager
//
//  Created by globalwings  on 2018/11/13.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit
let width = UIScreen.main.bounds.width
class ProgressVC: UIViewController {
    let slider = UISlider(frame: CGRect.zero)
    
    let layerOne = ProgressOneLayer()
    let layerTwo = ProgressTwoLayer()
    let layerThree = ProgressThreeLayer()
    let layerFour = ProgressFourLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        slider.frame = CGRect(x: 50, y: 70, width:width - 100 , height: 30)
        let lWH : CGFloat = 100
        let horSpace = (width - 2 * lWH) / 3
        layerOne.frame = CGRect(x: horSpace, y: 110, width: lWH, height: lWH)
        layerTwo.frame = CGRect(x: horSpace * 2 + lWH, y: 110, width: lWH, height: lWH)
        layerThree.frame = CGRect(x: horSpace, y: 110 + lWH + 30, width: lWH, height: lWH)
        layerFour.frame = CGRect(x: horSpace * 2 + lWH, y: 110 + lWH + 30, width: lWH, height: lWH)
    }
}
extension ProgressVC{
    private func addUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
        layerOne.number = 0.0
        layerTwo.number = 0.0
        layerThree.number = 0.0
        layerFour.number = 0.0
        view.layer.addSublayer(layerOne)
        view.layer.addSublayer(layerTwo)
        view.layer.addSublayer(layerThree)
        view.layer.addSublayer(layerFour)
    }
    @objc func sliderValue(){
        layerOne.number = Double(slider.value)
        layerTwo.number = Double(slider.value)
        layerThree.number = Double(slider.value)
        layerFour.number = Double(slider.value)
    }
}
//圆形进度条的父类, 用于显示百分比文本
class ProgressLayer: CALayer {
    var number : Double = 0.0{
        didSet{
            tLayer.string = String(format: "%.01f%%", number * 100)
            tLayer.setNeedsDisplay()
            setNeedsDisplay()
        }
    }
    let tLayer : CATextLayer = {
       let l = CATextLayer()
        let font = UIFont.systemFont(ofSize: 12)
        l.font = font.fontName as CFTypeRef
        l.fontSize = font.pointSize
        l.foregroundColor = UIColor.black.cgColor
        l.alignmentMode = .center
        l.contentsScale = UIScreen.main.scale
        l.isWrapped = true
        l.string = ""
        return l
    }()
    override init() {
        super.init()
        super.addSublayer(tLayer)
    }
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSublayers() {
        super.layoutSublayers()
        let tH = NSString(string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)], context: nil).height
        tLayer.frame = CGRect(x: 0, y: frame.height * 0.5 - tH * 0.5, width: frame.width, height: tH)
    }
    
}
class ProgressOneLayer : ProgressLayer {
    override func draw(in ctx: CGContext) {
        let radius = frame.width * 0.45
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        ctx.setStrokeColor(UIColor.cyan.cgColor)
        ctx.setLineWidth(radius * 0.08)
        ctx.setLineCap(.round)
        let endAngle = CGFloat.pi * 2 * CGFloat(number) - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radius, startAngle: -0.5 * CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
        
    }
}
class ProgressTwoLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        let radius = frame.width * 0.45
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        ctx.setFillColor(UIColor.yellow.cgColor)
        
        let endAngle = CGFloat.pi * 2 * CGFloat(number) - CGFloat.pi * 0.5
        ctx.move(to: center)
        ctx.addLine(to: CGPoint(x: center.x, y: frame.height * 0.05))
        ctx.addArc(center: center, radius: radius, startAngle: -0.5 * CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.closePath()
        ctx.fillPath()
    }
}
class ProgressFourLayer : ProgressLayer {
    override func draw(in ctx: CGContext) {
        let radius = frame.width * 0.45
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.8).cgColor)
        ctx.setLineWidth(radius * 0.07)
        ctx.addEllipse(in: CGRect(x: frame.width * 0.05, y: frame.height * 0.05, width: frame.width * 0.9, height: frame.height * 0.9))
        ctx.strokePath()
        
        
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(radius * 0.08)
        ctx.setLineCap(.round)
        let endAngle = CGFloat.pi * 2 * CGFloat(number) - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radius, startAngle: -0.5 * CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
        
    }
}
class ProgressThreeLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        let radius = frame.width * 0.45
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        
        ctx.setStrokeColor(UIColor.cyan.withAlphaComponent(0.3).cgColor)
        ctx.setLineWidth(radius * 0.05)
        ctx.addEllipse(in: CGRect(x: frame.width * 0.05, y: frame.height * 0.05, width: frame.width * 0.9, height: frame.height * 0.9))
        ctx.strokePath()
        
        ctx.setFillColor(UIColor.yellow.cgColor)

        let startAngle = CGFloat.pi * 0.5 - CGFloat(number) * CGFloat.pi
        let endAngle = CGFloat.pi * 0.5 + CGFloat(number) * CGFloat.pi
        
        ctx.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx.closePath()
        ctx.fillPath()
    }
}
