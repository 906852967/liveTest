//
//  Extend.swift
//  puzzle
//
//  Created by globalwings  on 2018/10/11.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit
import GameplayKit
class Extension : NSObject  {
    class func calculateSize(image : UIImage, x : Int, y : Int) -> [UIImage]{
        let size = image.size
        let width = Double(size.width) / Double(x)
        let height = Double(size.height) / Double(y)
        var images : [UIImage] = []
        for i in 0..<y {
            for j in 0..<x {
                let newX = Double(j) * width
                let newY = Double(i) * height
                let rect = CGRect(x: newX, y: newY, width: width, height: height)
                let newImage = imageCutSize(image: image, frame: rect)
                let index = i * x + j
                images.append(newImage!)
            }
        }
        images.removeLast()
        images.append(UIImage(named: "white")!)
        //数组随机
         let newImages = randomSwapImages(images)
        //数组交换位置
       // images.swapAt(0, images.count - 1)
        return newImages as! [UIImage]
    }
    class func imageCutSize(image : UIImage, frame : CGRect) -> UIImage?{
        //获取截取y区域的大小
        let sz = frame.size
        //获取截取区域的坐标
        let origin = frame.origin
        //创建sz大小的上下文，背景是否透明：NO，缩放尺寸：0表示不缩放
        UIGraphicsBeginImageContextWithOptions(sz, false, 0)
        //移动坐标原点绘制图片，由于上下文坐标系与图片自身坐标系是相反的，所以绘制坐标需要取反
        image.draw(at: CGPoint(x: -origin.x, y: -origin.y))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
    class func randomSwapImages(_ images: [Any]) -> [Any]{
        let newArray = images
        //交换 方法1
//        for i in 0..<(newArray.count - 1){
//            let j = Int(arc4random_uniform(UInt32(images.count - 1))) + 1
//            if i != j{
//                newArray.swapAt(i, j)
//            }
//        }
//        return newArray
        
        //交换 方法2
        var array = images
        array.shuffle()
        let shuffleAry = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: newArray)
        return shuffleAry
    }
    // 检查无解
//    class func makePuzzleCanBeSolved(_ imagesCount : Int) -> Bool{
//        //奇偶性总值
//        let sum = 0
//        for i in 0..<imagesCount {
//            for j in 0..<imagesCount{
//                if j == i + 1{
//
//                }
//            }
//        }
//        return true
//    }
}

