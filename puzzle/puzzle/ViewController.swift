//
//  ViewController.swift
//  puzzle
//
//  Created by globalwings  on 2018/9/17.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var chooseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func chooseClick(_ sender: UIButton) {
        pageSkip()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension ViewController{
    func setUpUI() {
        chooseButton.layer.borderColor = UIColor.white.cgColor
        chooseButton.layer.borderWidth = 1
    }
    func pageSkip(){
        self.present(PhotoVC(), animated: true, completion: nil)
    }
}

