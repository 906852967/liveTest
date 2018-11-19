//
//  ViewController.swift
//  DispatchTry
//
//  Created by globalwings  on 2018/11/9.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        dispatchTry()
    }

}
extension ViewController{
    func dispatchTry(){
        let group = DispatchGroup()
        let queueBook = DispatchQueue(label: "book")
        let workItem = DispatchWorkItem{
            print("Book1")
        }
        workItem.perform()
        let queueVideo = DispatchQueue(label: "video")
        let videoWord = DispatchWorkItem{
            sleep(3)
            print("video1")
        }
        videoWord.perform()
        queueBook.async(group: group, execute: workItem)
        queueVideo.async(group: group, execute: videoWord)
        
        group.notify(queue: DispatchQueue.main) {
            print("完成")
        }
        
        
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(10)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.view.backgroundColor = UIColor.cyan
        }
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                self.view.backgroundColor = UIColor.red
            })
        }
    }
    func queueTest(){
        let queue = DispatchQueue(label: "com.geselle.demoQueue")
        let qos = DispatchQoS.default
        let label = "com.geselle.demoQueue"
        let attributs = DispatchQueue.Attributes.concurrent
        let autoreleaseFrequency = DispatchQueue.AutoreleaseFrequency.never
        let queues = DispatchQueue(label: label, qos: qos, attributes: attributs, autoreleaseFrequency: autoreleaseFrequency, target: nil)
        
        //获取系统队列
        let mainQueue = DispatchQueue.main
        let globalQueue = DispatchQueue.global()
        let globalQueueWidthQos = DispatchQueue.global(qos: .userInitiated)
        
        
        
    }
}

