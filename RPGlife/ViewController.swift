//
//  ViewController.swift
//  RPGlife
//
//  Created by 上田　護 on 2019/01/17.
//  Copyright © 2019 mamoru.ueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var barView: UIView!
    var timeCount: Bool = false
    var start: Date = Date()
    var width:CGFloat!
    var timer: Timer!
    var gauge: CGFloat!
    var startFlag: Bool = false
    var mode: String!
    var buttonArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スクリーンの横縦幅
        let screenWidth:CGFloat = self.view.frame.width
        let screenHeight:CGFloat = self.view.frame.height
        gauge = screenWidth*4/5
        width = screenWidth*4/5
        let Height = screenHeight/3
        // ボタンのインスタンス生成
        
        createButton(buttonLabel: "作業をする", buttonSize: CGSize(width:screenWidth/2,height:screenHeight/20), buttonPoint: CGPoint(x:screenWidth/2,y:screenHeight*10/20))

        createButton(buttonLabel: "休む", buttonSize: CGSize(width:screenWidth/2,height:screenHeight/20), buttonPoint: CGPoint(x:screenWidth/2,y:screenHeight*12/20))
        // Do any additional setup after loading the view, typically from a nib.
        
        // サイズを生成 (x, y, width, height): x,yは表示位置
        let rect    = CGRect(x:screenWidth/2, y:Height, width:gauge, height:screenHeight/15)
        // 色を生成
        let bgColor = UIColor.blue
        // 生成したサイズを使って、ビューを生成
        barView    = UIView(frame: rect)
        barView.center = CGPoint(x:screenWidth/2,y:Height)
        // ビューの背景に色を設定
        barView.backgroundColor = bgColor
        self.view.addSubview(barView)
    }

    func createButton(buttonLabel: String, buttonSize: CGSize, buttonPoint: CGPoint){
        let button = UIButton() // ボタンのインスタンス生成
        button.frame.size = buttonSize   // ボタンの位置とサイズを設定
        button.center = buttonPoint   // ボタンの位置とサイズを設定
        button.setTitle(buttonLabel, for:UIControl.State.normal)  // ボタンのタイトルを設定
        button.setTitleColor(UIColor.white, for: .normal)       // タイトルの色
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 36)// ボタンのフォントサイズ
        button.backgroundColor = UIColor.init(red:0.9, green: 0.9, blue: 0.2, alpha: 1)// 背景色
        if(buttonLabel == "作業をする"){
            button.addTarget(self,
                         action: #selector(ViewController.workBtn),
                         for: .touchUpInside)                   // タップされたときのaction
        }else{
            button.addTarget(self,
                             action: #selector(ViewController.breakBtn),
                             for: .touchUpInside)                   // タップされたときのaction
        }
        buttonArray.append(button)
        self.view.addSubview(button)                            // Viewにボタンを追加
    }
    
    //ボタンアクション
    @IBAction func workBtn(sender: AnyObject) {
        mode = "work"
        timeCount = !timeCount
        print("Debug workBtn:\(timeCount)")
        
        //timerが止まっているなら.
        if timer == nil || timer.isValid == false {
            startFlag = true
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)  //timerを生成する.
        }else{  //ストップする時timeCount == flase
            timer.invalidate()  //timerを破棄する.
            gauge = width
            getInterval()
        }
    }
    
    //ボタンアクション
    @IBAction func breakBtn(sender: AnyObject) {
        mode = "break"
        timeCount = !timeCount
        print("Debug workBtn:\(timeCount)")
        //timerが止まっているなら.
        if timer == nil || timer.isValid == false {
            buttonArray[0].isEnabled = false
            startFlag = true
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)  //timerを生成する.
        }else{  //ストップする時timeCount == flase
            buttonArray[0].isEnabled = true
            timer.invalidate()  //timerを破棄する.
            gauge = width
            getInterval()
        }
    }
    
    func getInterval() -> Double {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let now = Date()
        print(now)
        var timeInterval: TimeInterval = 0.0

        if !timeCount{

            print(start)
            timeCount = !timeCount
            print("Debug timeCount \(timeCount)")
        }else{
            if startFlag == true {start = now }//現時刻を基準にする
            startFlag = false
            timeInterval = Date().timeIntervalSince(start) //基準からの経過時間
            print(timeInterval)
        }
//        return formatter.string(from: now)
        return timeInterval
    }
    
    @objc func timerUpdate() {
//        print("update")
        // スクリーンの横縦幅
        let screenHeight:CGFloat = self.view.frame.height
        let screenWidth:CGFloat = self.view.frame.width

        if mode == "work"{
            width = gauge - CGFloat(getInterval())*10
        }else{
            width = gauge + CGFloat(getInterval())*10
        }
        
        if width >= screenWidth*4/5{
            width = screenWidth*4/5
            timer.invalidate()  //timerを破棄する.
        }else if width <= 0{
            width = 0
            timer.invalidate()  //timerを破棄する.
        }
        //アニメーション処理
        UIView.animate(withDuration: 1.0, animations: {
            //拡大縮小の処理
            self.barView.frame.size = CGSize(width:self.width, height:screenHeight/15)
        })
        print(width)
    }
}
