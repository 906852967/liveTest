//
//  RACVC.swift
//  TaskManager
//
//  Created by globalwings  on 2018/11/13.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit

class RACVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       view.backgroundColor = UIColor.gray
        
        let v = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        v.backgroundColor = UIColor.blue
        view.addSubview(v)
        
        v.layer.shadowColor = UIColor.cyan.cgColor
        v.layer.shadowOffset = CGSize(width: 100, height: 100)
        v.layer.shadowOpacity = 0.15
        v.layer.shadowRadius = 1
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = v.bounds
        
        let fromColor = UIColor.green.cgColor
        //let minColor = UIColor.red.cgColor
        let toColor = UIColor.blue.cgColor
        
        
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 1]
        v.layer.addSublayer(gradientLayer)
    }
}
extension RACVC{
    func tickTest(){
        let ticketsCount = 50
//        self.ticketsCount = 50;
//        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//        for (NSInteger i = 0; i < 5; i++) {
//            dispatch_async(queue, ^{
//                for (int i = 0; i < 10; i++) {
//                    [self sellingTickets];
//                }
//                });
        
           
    }
}
