//
//  GCDVC.swift
//  puzzle
//
//  Created by globalwings  on 2018/12/13.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit
class GCDVC: BaseViewController {
    override func viewDidLoad() {
        super .viewDidLoad()
        let timer : Timer = Timer.scheduledTimer(withTimeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
        
        
    }
    //竞态条件
    func race_condition(){
        var num = 0
        DispatchQueue.global().async {
            for _ in 1...10000{
                num += 1
            }
        }
        for _ in 1...10000{
            num += 1
        }
    }
    //优先倒置（Priority Inverstion）。指低优先级的任务会因为各种原因先于高优先级任务执行。
    func priority_Inverstion(){
        var highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
        var lowPriorityQueue = DispatchQueue.global(qos: .utility)
        
        let semaphore = DispatchSemaphore(value: 1)
        
        lowPriorityQueue.async {
            semaphore.wait()
            for i in 0...10{
                print(i)
            }
            semaphore.signal()
        }
        
        highPriorityQueue.async {
            semaphore.wait()
            for i in 11...20{
                print(i)
            }
            semaphore.signal()
        }
        
    }
}
