//
//  PhotoVC.swift
//  puzzle
//
//  Created by globalwings  on 2018/9/21.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit
import Koloda
class PhotoVC: UIViewController {
    @IBOutlet weak var refreshButton: UIButton!
    
    lazy var kolodaView : KolodaView = {
        let kolodaView : KolodaView = KolodaView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        kolodaView.dataSource = self
        kolodaView.delegate = self
        view.addSubview(kolodaView)
        return kolodaView
    }()
    
    var images : [UIImage?] = [UIImage(named: "1.jpg"),UIImage(named: "2.jpg"),UIImage(named: "3.jpg"),UIImage(named: "4.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.reloadData()
        
        view.bringSubview(toFront: refreshButton)
        
    }
    @IBAction func refreshClick(_ sender: UIButton) {
        kolodaView.revertAction()
    }
    
}
extension PhotoVC : KolodaViewDelegate{
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
    }
}
extension PhotoVC : KolodaViewDataSource{
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return images.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: images[index])
    }
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let puzzleVC = PuzzleVC()
        puzzleVC.images = Extension.calculateSize(image: images[index]!, x: 4, y: 4)
        print(puzzleVC.images)
        self.present(puzzleVC, animated: true, completion: nil)
    }
}
