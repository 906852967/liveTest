//
//  PuzzleVC.swift
//  puzzle
//
//  Created by globalwings  on 2018/9/25.
//  Copyright © 2018年 globalwings . All rights reserved.
//

import UIKit

let count = 4
let cellWidth = Double(UIScreen.main.bounds.size.width) / Double(count)
let cellHeight = cellWidth
let cellIdentifier = "puzzleCell"
enum CompassPoint {
    case North
    case South
    case East
    case West
}
struct Fix {
    var firstValue : Int
    let length : Int
}
class PuzzleVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var images : [UIImage] = []
    let zzz = CompassPoint.East
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        switch zzz {
        case .North:
            print("Lots of planets have a north")
        case .South:
            print("Watch out for penguins")
        case .East:
            print("Where the sun rises")
        case .West:
            print("Where the skies are blue")
        }
        var range = Fix(firstValue: 3, length: 3)
        range.firstValue = 4
            
        }
    }

extension PuzzleVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundView = UIImageView(image: (images[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location : (x : Int, y : Int) = (indexPath.row % count, indexPath.row / count)
        //点击的位置
        let nowLocation = location.y * count + location.x
        let whiteLocation = images.index(of: UIImage(named: "white")!)
        
        //判断是否在同一排
        if whiteLocation! / count == location.y {
            if whiteLocation == nowLocation + 1 || whiteLocation == nowLocation - 1{
                images.swapAt(nowLocation, whiteLocation!)
                collectionView.reloadData()
            }
        }else if whiteLocation == nowLocation + count || whiteLocation == nowLocation - count  {
            //交换数组
            images.swapAt(nowLocation, whiteLocation!)
            collectionView.reloadData()
        }
    }
    
    func userLogin(){
        var myUserName : Double?
        var myUserPsw : Double?
        guard let username = myUserName, let password = myUserPsw else {
            return
        }
        print("welcome")
    }
}
extension PuzzleVC{
    func setUI(){
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        tailorimage()
    }
    func gcdTest(){
        let queue =  DispatchGroup.init()
    }
    func tailorimage(){
        view.isOpaque = true
        let a = "\\\"\\aaa\(5)zzz🐥"
        let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
        print(a + "\(unusualMenagerie.count)")
        let aArray : [String] = Array(repeating: "2.6", count: 5)
        
        print(aArray)
        for (index, value) in aArray.enumerated(){
            print("\(index) + \(value)")
        }
        var latters = Set<String>()
        latters.insert("a")
        latters.insert("2")
        print(latters)
        if latters.contains("2") {
            print("YES")
        }
        if aArray.contains("zzz") {
            print("YES")
        }
        if aArray.isEmpty{
            
        }
        
        print(sexxx(number: 2,3,4,5,6,7,8,9))
        print(sex(number: 13))
        let c = sum()
        //嵌套函数调用
        print(c(5))
        var currentValue = -4
        let moveNearerToZero = chooseStepFunction(backwards: currentValue > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        
        //闭包
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(names.sorted())
//        let reversed = names.sort({(s1 : String, s2 : String) -> Bool in return s1 > s2 })
        //闭包表达式语法
        var reversed = names.sorted(by: {(s1 : String, s2 : String) -> Bool in return s1 > s2 })
        //运算符函数
        reversed = names.sorted(by: <)
        //根据上下文推断类型
        reversed = names.sorted(by: {s1, s2 in return s1 > s2})
        //单表达式闭包隐式返回
        reversed = names.sorted(by: {s1, s2 in s1 > s2})
        //参数名称缩写
        reversed = names.sorted(by: {$0 > $1})
        print(reversed)
        someFunc {
            
        }
        let strings = names.map { (number) -> String in
            var output = ""
            output += number
            return output
        }
        print(strings)
        let cc = mack(forint: 7)
        print(cc())
        
        
        let veg = "red peper"
        switch veg {
        case "ces":
            print("aaa")
        case let z:
            print(z)
        case let x where x.hasSuffix("peper"):
            print(x)
            print("zzz")
        default:
            print("ccc")
        }
        
        let theAce = BlackjackCard(rank: .Ace, suit: .Spades)
        print("theAceOf\(theAce.description)")
        
        
    }
    func swapTwoValues<T>( a : inout T, _ b :inout T){
        let temp = a
        a = b
        b = temp
    }
    func sex(number : Int = 12) -> Int{
        return number + number
    }
    func sexxx(number : Int...) -> Int{
        var sum = 0
        for numbers in number {
            sum += numbers
        }
        return sum
    }
    func sum() -> (Int) -> Int{
        func setfor(input : Int) ->Int{
            return input + 1
        }
        return setfor
    }
    func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backwards ? stepBackward : stepForward
    }
    func backwards(s1 : String, s2 : String)-> Bool{
        return s1 > s2
    }
    func someFunc(close:()-> Void){
        
    }
    func mack(forint amout:Int)->() -> Int{
        var runn = 0
        
        func incorem() -> Int{
            runn += amout
            return runn
        }
         let a = abc.ccc
        print(abc.ccc)
        return incorem
    }
    struct abc {
        static var ccc : Int{
            return 3
        }
    }
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveByX(deletaX : Double, y deletaY : Double){
            self =  Point(x: x + deletaX, y: y + deletaY)
        }
    }
    enum TriStateSwitch {
        case Off, Low, High
        mutating func next(){
            switch self {
            case .Off:
                self = .Off
            case .Low:
                self = .Low
            default:
                self = .High
            }
        }
    }
    struct Matrix {
        let rows : Int, columns : Int
        var grid : [Double]
        init(rows : Int, columns : Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        func indexIsValue(row : Int, colum : Int) -> Bool{
            return row >= 0 && row < rows && colum >= 0 && colum < columns
        }
        subscript(row : Int, column : Int) -> Double{
            get{
                assert(indexIsValue(row: row, colum: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set{
                assert(indexIsValue(row: row, colum: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
}
struct BlackjackCard {
    // 嵌套定义枚举型Suit
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // 嵌套定义枚举型Rank
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

//class RecipeIngredinet : UIView{
//    var quantule : Int
//    init(frame : CGRect, quantule : Int) {
//        self.quantule = quantule
//        super.init(frame: frame)
//    }
//    override convenience init(frame: CGRect) {
//        self.init(frame: frame, quantule: quantule)
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
