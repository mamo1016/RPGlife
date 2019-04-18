//
//  ViewController.swift
//  RPGlife
//
//  Created by 上田　護 on 2019/01/17.
//  Copyright © 2019 mamoru.ueda. All rights reserved.
//

import UIKit
import BAFluidView

var work: Bool = false
class ViewController: UIViewController {
    var barView: UIView!
    var backView: UIView!
    var experienceView: UIView!
    var experience: Int = 0
    var levelUpdeta: Int = 0
    var experienceSaveDeta: Int = 0
    var timeCount: Bool = false
    var start: Date = Date()
    var width:CGFloat!
    var timer: Timer!
    var gauge: CGFloat!
    var reset: Bool = false
    
    var buttonArray: [UIButton] = []
    let save = UserDefaults.standard
    var labelArray: [UILabel] = []
    var experienceBar: Int = 0
    var experienceBackView: UIView!
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var graphView:PieGraph!
    var animeView:BAFluidView!
    //アニメーションのViewを生成
//    var animeView = BAFluidView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        save.set(0, forKey: "experience")//保存
        // スクリーンの横縦幅
        let screenWidth:CGFloat = self.view.frame.width
//        let screenHeight:CGFloat = self.view.frame.height
        let _:CGFloat = self.view.frame.height
        gauge = screenWidth*4/5
        width = screenWidth*4/5
//        let Height = screenHeight/3
        view.backgroundColor = UIColor(hex: "333333", alpha: 1.0)
        
        
//        layout()
        var params = [Dictionary<String,AnyObject>]()
//        params.append(["value":7 as AnyObject,"color":UIColor.red])
//        params.append(["value":5 as AnyObject,"color":UIColor.blue])
//        params.append(["value":8 as AnyObject,"color":UIColor.green])
        params.append(["value":1 as AnyObject,"color":UIColor.yellow])
        graphView = PieGraph(frame: CGRect(x: screenWidth/2-screenWidth*2/5, y: screenWidth/2 - screenWidth*2/5, width: screenWidth*4/5, height: screenWidth*4/5), params: params)
//        graphView.center = CGPoint(x:screenWidth/2,y:screenHeight/2)
//        graphView.center = CGPoint(x: screenWidth/2, y: 160)
        self.view.addSubview(graphView)
        graphView.startAnimating()
//        let animeView = BAFluidView(frame: self.view.frame)
        animeView = BAFluidView(frame:self.view.frame,startElevation: 0.0)
        //波の高さを設定(0~1.0)
//        animeView.fill(to: 0.8)
        //波の境界線の色
        animeView.strokeColor = .white
        animeView.fillRepeatCount = 1
        animeView.fillAutoReverse = false
        animeView.fillDuration = 10
        animeView.fill(to: 0.3)
        //波の色
        animeView.fillColor = UIColor(red: 0.274, green: 0.288, blue: 0.297, alpha: 1.0)
        
//        animeView.fillDuration = 10
        animeView.lineWidth = 1
        //        view.fillRepeatCount = 1;
//        animeView.startAnimation()
//        animeView.startAnimation()
        animeView.startTiltAnimation()
//        self.view.addSubview(animeView)
        self.view.addSubview(animeView)
        
        // ボタン
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btn.backgroundColor = .blue
        btn.setTitle("ボタン" , for: .normal)
        btn.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    @IBAction func btnAction(sender: UIButton){
            print("test")
        animeView.removeFromSuperview()
        //         animeView = BAFluidView(frame:self.view.frame,startElevation: 0.4)
//         animeView.keepStationary()
//        animeView.
//        animeView = BAFluidView(frame:self.view.frame,startElevation: 0.3)
//        animeView.fill(to: 0.9)
//        animeView.lineWidth = 10
    }

    func layout(){
        // スクリーンの横縦幅
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height

        // ボタンのインスタンス生成
        createButton(buttonLabel: "work", buttonSize: CGSize(width:screenWidth/2,height:screenHeight/20), buttonPoint: CGPoint(x:screenWidth/2,y:screenHeight*10/20))
        
        //        createButton(buttonLabel: "休む", buttonSize: CGSize(width:screenWidth/2,height:screenHeight/20), buttonPoint: CGPoint(x:screenWidth/2,y:screenHeight*12/20))
        // Do any additional setup after loading the view, typically from a nib.
        
        // サイズを生成 (x, y, width, height): x,yは表示位置
        let rect = CGRect(x:screenWidth/10,y:screenHeight/3,width:screenWidth-screenWidth/5,height:screenHeight/15)
        // 色を生成
        let bgColor = UIColor.red
        // 生成したサイズを使って、ビューを生成
        barView    = UIView(frame: rect)
        //        barView.center = CGPoint(x:screenWidth/2,y:Height)
        //        barView.frame = barView.frame
        // ビューの背景に色を設定
        barView.backgroundColor = bgColor
        self.view.addSubview(barView)
        //右上と左下を角丸にする設定
        barView.layer.cornerRadius = 15
        barView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        backView    = UIView(frame: rect)
        // ビューの背景に色を設定
        backView.backgroundColor =  UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.5)
        self.view.insertSubview(backView, at: 0)        //右上と左下を角丸にする設定
        backView.layer.cornerRadius = 15
        backView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        // 生成したサイズを使って、ビューを生成
        experienceView = UIView(frame: CGRect(x:screenWidth/10,y:screenHeight*13/15,width:screenWidth-screenWidth/5,height:screenHeight/15))
        experienceView.frame.size = CGSize(width:CGFloat(experienceSaveDeta),height:screenHeight/25)
        // ビューの背景に色を設定
        experienceView.backgroundColor = UIColor(red: 0.6, green: 0.2, blue: 0.4, alpha: 1.0)
        self.view.addSubview(experienceView)
        //右上と左下を角丸にする設定
        experienceView.layer.cornerRadius = 15
        experienceView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
//        print(experienceView.frame)
        
        // 生成したサイズを使って、ビューを生成
        experienceBackView = UIView(frame: CGRect(x:screenWidth/10,y:screenHeight*13/15,width:screenWidth-screenWidth/5,height:screenHeight/15))
        experienceBackView.frame.size = CGSize(width:screenWidth*4/5,height:screenHeight/25)
        // ビューの背景に色を設定
        experienceBackView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)
        self.view.insertSubview(experienceBackView, at: 0)
        //右上と左下を角丸にする設定
        experienceBackView.layer.cornerRadius = 15
        experienceBackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        
        createLabel(labelRect: CGRect(x: screenWidth/2,y: screenHeight*5/8,width: screenWidth/4 ,height:screenWidth/4), labelText: "0")
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        // スーパークラスのメソッドを呼び出します。
        super.viewDidDisappear(animated)
        
        // 端末回転の通知機能の設定を解除します。
        let center = NotificationCenter.default
        let name = UIDevice.orientationDidChangeNotification
        center.removeObserver(self, name: name, object: nil)
    }
    
    
    func createLabel(labelRect: CGRect,labelText: String){
        let label: UILabel = UILabel(frame: labelRect)// Labelを作成.
        label.center = labelRect.origin
        label.backgroundColor = UIColor.orange  // UILabelの背景をオレンジ色に.
        label.layer.masksToBounds = true        // UILabelの枠を丸くする.
        label.layer.cornerRadius = 20.0         // 丸くするコーナーの半径.
        label.textColor = UIColor.white         // 文字の色を白に定義.
        label.text = labelText            // UILabelに文字を代入.
        label.font = UIFont.systemFont(ofSize: labelRect.width/2)   //フォントサイズ
        label.shadowColor = UIColor.gray        // 文字の影をグレーに定義.
        label.textAlignment = NSTextAlignment.center// Textを中央寄せにする.
        self.view.addSubview(label)             // ViewにLabelを追加.
        labelArray.append(label)
    }
    
    func createButton(buttonLabel: String, buttonSize: CGSize, buttonPoint: CGPoint){
        let button = UIButton() // ボタンのインスタンス生成
        button.frame.size = buttonSize   // ボタンの位置とサイズを設定
        button.center = buttonPoint   // ボタンの位置とサイズを設定
        button.setTitle(buttonLabel, for:UIControl.State.normal)  // ボタンのタイトルを設定
        button.setTitleColor(UIColor.white, for: .normal)       // タイトルの色
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 20)// ボタンのフォントサイズ
        button.backgroundColor = UIColor.init(red:0.1, green: 0.5, blue: 0.1, alpha: 1)// 背景色
        button.addTarget(self,
                         action: #selector(ViewController.workBtn),
                         for: .touchUpInside)                   // タップされたときのaction
        buttonArray.append(button)
        self.view.addSubview(button)                            // Viewにボタンを追加
    }
    
    //ボタンアクション
    @IBAction func workBtn(sender: AnyObject) {
        
        work = !work
//        up = true
        graphView.startAnimating()
        if work {
//            graphView.decleaseAnimating()
//            print("push work")
            buttonArray[0].setTitle("休む", for: UIControl.State.normal)
            buttonArray[0].backgroundColor = UIColor.init(red:0.1, green: 0.4, blue: 0.1, alpha: 1)
//            if let deta = save.object(forKey: "experience") { experienceSaveDeta = deta as! Int }
//            print("work\(experienceView.frame)")
        }else{
//            graphView.startAnimating()
//            print("push break")
            experienceSaveDeta = experience
            buttonArray[0].setTitle("作業する", for: UIControl.State.normal)
            buttonArray[0].backgroundColor = UIColor.init(red:0.1, green: 0.6, blue: 0.2, alpha: 1)
//            save.set(experience, forKey: "experience")//保存
        }
//        timeCount = !timeCount
//        print("Debug workBtn:\(timeCount)")
        reset = true
        //timerが止まっているなら.
        if timer == nil || timer.isValid == false {
//            startFlag = true
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)  //timerを生成する.
        }else{  //休憩する時
//            timer.invalidate()  //timerを破棄する.
            gauge = width
//            getInterval()
        }
    }
    
//    //ボタンアクション
//    @IBAction func breakBtn(sender: AnyObject) {
//        work = !work
//        timeCount = !timeCount
////        print("Debug workBtn:\(timeCount)")
//        //timerが止まっているなら.
//        if timer == nil || timer.isValid == false {
//            buttonArray[0].isEnabled = false
//            reset = true
//            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)  //timerを生成する.
//        }else{  //ストップする時timeCount == flase
//            buttonArray[0].isEnabled = true
//            timer.invalidate()  //timerを破棄する.
//            gauge = width
//            getInterval()
//        }
//    }
    
    func getInterval() -> Double {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let now = Date()
//        print(now)
        var timeInterval: TimeInterval = 0.0

        if !timeCount{ //タイマーが動いていない時
//            print(start)
            timeCount = !timeCount
//            print("Debug timeCount \(timeCount)")
        }else{
            if reset == true {start = now }//現時刻を基準にする
            reset = false
            timeInterval = Date().timeIntervalSince(start) //基準からの経過時間
//            print(timeInterval)
//            print(timeInterval)
            if timeInterval < 0.01{
                timeInterval = 0
            }
        }
//        return formatter.string(from: now)
        timeInterval = timeInterval*10
        return floor(timeInterval)/10
    }
    
    @objc func timerUpdate() {
////        print("update")
//        // スクリーンの横縦幅
        let screenHeight:CGFloat = self.view.frame.height
        let screenWidth:CGFloat = self.view.frame.width

        save.set(experience, forKey: "experixence")
        
            labelArray[0].text = String(experience/(Int(screenWidth*4/5)))

        if width > screenWidth*4/5{
            width = screenWidth*4/5
            timer.invalidate()  //timerを破棄する.
//            print("stop")
            reset = true
            gauge = width
        }else if width < 0{
            width = 0
            timer.invalidate()  //timerを破棄する.
            reset = true
            gauge = width
//            print("stop")
            experienceSaveDeta = experience
//            save.set(experience, forKey: "experixence")
        }
        
        if work{//ワーク中
            width = gauge - CGFloat(getInterval())
            experience = Int(getInterval()) + experienceSaveDeta
            experienceBar = experience % Int(screenWidth*4/5)
        }else{//休憩中
            width = gauge + CGFloat(getInterval())
        }
//        print("timeupDate:\(experience)/\((Int(screenWidth)*4/5)) = \(experience/(Int(screenWidth)*4/5))")

        //アニメーション処理
        UIView.animate(withDuration: 1.0, animations: {
            //拡大縮小の処理
            self.barView.frame = CGRect(x:screenWidth/10,y:screenHeight/3,width:self.width, height:screenHeight/15)
            //拡大縮小の処理
            self.experienceView.frame = CGRect(x:screenWidth/10,y:screenHeight*13/15,width:CGFloat(self.experienceBar), height:screenHeight/25)
        })
    }
    
}
