//
//  ViewController.swift
//  设计模式
//
//  Created by globalwings  on 2018/11/19.
//  Copyright © 2018 globalwings . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalPeiceLabel: UILabel!
    @IBOutlet weak var textPrice: UITextField!
    @IBOutlet weak var txtNum: UITextField!
    let items = ["正常收费", "打八折", "打七折", "打五折"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func totalAction(_ sender: UIButton) {
        totalPeiceLabel.text = String(btnOk_click("打八折"))
    }
    
}

extension ViewController{
    func btnOk_click(_ selectedString : String) -> Double{
        var totalPrice : Double = 0
        switch selectedString {
        case "正常收费":
            totalPrice =  (textPrice.text! as NSString).doubleValue * (txtNum.text! as NSString).doubleValue
        case "打八折":
            totalPrice = (textPrice.text! as NSString).doubleValue * (txtNum.text! as  NSString).doubleValue * 0.8
        case "打七折":
            totalPrice = (textPrice.text! as NSString).doubleValue * (txtNum.text! as NSString).doubleValue * 0.7
        default:
            return totalPrice
            
        }
        return totalPrice
    }
}

//现金收费抽象类
class CashSuper: NSObject {
    public func acceptCash(_ money : Double) -> Double{
        return 0.0
    }
}

//正常收费类
class CashNormal: CashSuper {
    override func acceptCash(_ money: Double) -> Double{
        return money
    }
}
//打折收费子类
class CashRebate: CashSuper {
    var moneyRebate = 0.0
    init(_ moneyRebateString : String){
        moneyRebate = (moneyRebateString as NSString).doubleValue
    }
    override func acceptCash(_ money: Double) -> Double {
        return money * moneyRebate
    }
}
//返利收费子类
class CashReturn : CashSuper {
    var moneyCondition = 0.0
    var moneyReturn = 0.0
    init(moneyConditionString : String, moneyReturnString : String ) {
        moneyReturn = (moneyReturnString as NSString).doubleValue
        moneyCondition = (moneyConditionString as NSString).doubleValue
    }
    override func acceptCash(_ money: Double) -> Double {
        var result = 0.0
        if money >= moneyCondition{
            result = money - floor(money / moneyCondition) * moneyReturn
        }
        return result
    }
}
//现金收费子类
class CashFactory : NSObject {
    func createCashAccept(_ type : String) -> CashSuper{
        var cs : CashSuper
        switch type {
        case "正常收费":
            cs = CashNormal()
        case "满300返100":
            cs = CashReturn(moneyConditionString: "300", moneyReturnString: "100")
        case "打8折":
            cs = CashRebate("0.8")
        default:
            return CashSuper()
        }
        return cs
    }
}
//Context
class CashContext : NSObject {
    var cs : CashSuper
    init(_ type : String) {
        switch type {
        case "正常收费":
            cs = CashNormal()
        case "满300返100":
            cs = CashReturn(moneyConditionString: "300", moneyReturnString: "100")
        case "打8折":
            cs = CashRebate("0.8")
        default:
            cs = CashSuper()
        }
    }
    func getResult(_ money : Double) -> Double{
        return cs.acceptCash(money)
    }
}


