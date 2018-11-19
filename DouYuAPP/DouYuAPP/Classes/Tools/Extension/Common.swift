//
//  Common.swift
//  DouYuAPP
//
//  Created by globalwings  on 2018/4/20.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit
let kStausBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabbarH : CGFloat = 44
let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
let access_key = "7106ea944328f46ddb7ebcfbd60d92ac"
let actionKey = "actionKey"
let appkey = "27eb53fc9058f8c3"
let build = "6720"
let channel = "appstore"
let device = "phone"
let mobi_app = "iphone"
let platform = "ios"
let sign = "dec0024c5dbb4e8b5e794712ee73cbd0"
let ts = "1527493730"
struct location{
    var x : Double
    var y : Double
    func test(){
        
    }
    mutating func mobeH(distance : Double){
        self.x += distance
    }
    init(x : Double, y : Double, c : Double) {
        self.x = x
        self.y = y
    }
    init(xyStr : String) {
        let array = xyStr.components(separatedBy: ",")
        let item1 = array[0]
        let item2 = array[1]
        self.x = Double(item1) ?? 0
        self.y = Double(item2) ?? 0
    }
    var 元组 = (name : "1", age : "2")
}
class Person : NSObject{
    var name : String = ""{
        willSet(new){
            print(new)
            print(name)
        }
        didSet(old){
            print(old)
            print(name)
        }
    }
    var age : Int = 0
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
//        if let name = dict["name"] as? String{
//            self.name = name
//        }
//        if let age = dict["age"] as? Int {
//            self.age = age
//        }
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
class Student{
    var name : String = ""
    var book : Book?
}
class Book{
    var price : Double = 0
    var dog : Dog?
}
class Dog{
    var name : String = "11"
}

class zzz{
    func aaa(){
        let p = Student()
        let b = Book()
        let d = Dog()
        p.book = b
        b.dog = d
        d.name = "22"
    }
    let p = Student()
    let b = Book()
    let d = Dog()
    func zzz(){
        if let dog = p.book{
            if let toy = dog.dog{
                let price = toy.name
            }
        }
        let price = p.book?.dog?.name
        p.book?.dog?.name = "22233"
    }
    
}


























