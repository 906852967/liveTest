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
    public func acceptCash(_ money : Double){
        
    }
}

//正常收费类

