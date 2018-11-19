//
//  ViewController.swift
//  TaskManager
//
//  Created by globalwings  on 2018/11/12.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit
import iCarousel

let taskWidth = UIScreen.main.bounds.size.width * 5.0 / 7.0

class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}
extension ViewController : iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 7
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let cell = UIView(frame: CGRect(x: 0, y: 0, width: taskWidth, height: taskWidth * 16.0  / 9.0))
        
        
        let imageView = UIImageView(frame: cell.bounds)
        cell.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.cyan
        imageView.image = UIImage(named: "\(index + 1).jpg")
        
        cell.layer.shadowPath = UIBezierPath(roundedRect: imageView.frame, cornerRadius: 5).cgPath
        cell.layer.shadowRadius = 3
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize.zero
        
//        let label = UILabel(frame: cell.frame)
//        label.text = "\(index)"
//        label.font = UIFont.systemFont(ofSize: 50)
//        label.textAlignment = .center
//        cell.addSubview(label)
        return cell
    }
    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let scale = calcSaaleWithOffSet(Double(offset))
        let transLation = calcTranslationWiftOffSet(Double(offset))
        return CATransform3DScale(CATransform3DTranslate(transform, CGFloat(transLation) * taskWidth, 0, offset), CGFloat(scale), CGFloat(scale), 1.0)
    }
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        self.present(RACVC(), animated: true, completion: nil)
    }
    func setUI(){
        let catousel = iCarousel(frame:UIScreen.main.bounds)
        catousel.delegate = self
        catousel.dataSource = self
        catousel.type = .custom
        view.addSubview(catousel)
        catousel.bounceDistance = 0.1
        view.backgroundColor = UIColor.gray
    }
    //计算缩放
    func calcSaaleWithOffSet(_ offset : Double) -> Double{
        return offset * 0.02 + 1.0
    }
    //计算位移
    func calcTranslationWiftOffSet(_ offset : Double) -> Double{
        let z = 5.0 / 4.0
        let a = 5.0 / 8.0
        if offset >= z/a {
            return 2.0
        }
        return 1 / (z - a*offset) - 1/z
    }
}

