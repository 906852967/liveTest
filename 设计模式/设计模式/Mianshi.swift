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
        test()
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
    func _reverse<T>(_ chars : inout [T], _ start : Int, _ end : Int){
        var start = start, end = end
        while start < end {
            _swap(&chars, start, end)
            start += 1
            end -= 1
        }
    }
    func _swap<T>(_ chars : inout [T], _ p : Int, _ q : Int){
        (chars[p], chars[q]) = (chars[q], chars[p])
    }
    
    func reverseWords(s : String?) -> String?{
        guard let s = s else{
            return nil
        }
        var chars = Array(arrayLiteral: s.characters), start = 0
        _reverse(&chars, 0, chars.count - 1)
        for i in 0..<chars.count{
            if i == chars.count - 1 || chars[i + 1] as? String == " " {
                _reverse(&chars, start, i)
                start = i + 2
            }
        }
        return String(chars.description)
    }
    func test(){
        var string = "the sky is blue"
        
        let reserveString = reverseWords(s: string)
        print(reserveString)
    }
        
}
