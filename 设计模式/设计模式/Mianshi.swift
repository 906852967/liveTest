//
//  Mianshi.swift
//  设计模式
//
//  Created by 姜有伟 on 2018/11/26.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit

class Mianshi: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension Mianshi{
    func twoSum(nums : [Int], _ target : Int) -> Bool{
        var set = Set<Int>()
        for num in nums {
            if set.contains(target - num){
                 return true
            }
           set.insert(num)
        }
        return false
    }
    func theTwoSum(nums : [Int], _ target : Int) -> [Int]{
        var dic = [Int : Int]()
        for (i, num) in nums.enumerated() {
            if let lastIndex = dic[target - num]{
                return [lastIndex, i]
            }else{
                dic[num] = i
            }
        }
        fatalError("NO return")
    }
    
    //字符串反转
        
}
