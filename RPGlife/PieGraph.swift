//
//  PieGraph.swift
//  RPGlife
//
//  Created by 上田　護 on 2019/04/10.
//  Copyright © 2019 mamoru.ueda. All rights reserved.
//

import UIKit

class PieGraph: UIView {
    
    var _params:[Dictionary<String,AnyObject>]!
    var _end_angle:CGFloat!
    var d_end_angle:CGFloat!
    var up: Bool = false
    var down: Bool = false
    let viewController = ViewController()
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,params:[Dictionary<String,AnyObject>]) {
        super.init(frame: frame)
        _params = params;
        self.backgroundColor = UIColor.clear;
        _end_angle = -CGFloat(Double.pi / 2.0);
    }
    
    
    @objc func update(link: CADisplayLink){
        let angle = -CGFloat(Double.pi*2.0 / 10.0)
     
//        if up {
//            link.invalidate()
//            up = false
//        }
        
        if work{
            _end_angle = _end_angle + angle
            print("decleace")
            
        }else {//ボタンを押していない時
            _end_angle = _end_angle - angle
            print("increase")
        }
        
        if(_end_angle > CGFloat(Double.pi*2)) {
//            d_end_angle = _end_angle
            _end_angle = CGFloat(Double.pi*2)
            print("out1")
            //終了
            link.invalidate()
        } else  if  _end_angle < -CGFloat(Double.pi/2){
            _end_angle = -CGFloat(Double.pi/2)
            print("out2")
            //終了
            link.invalidate()
        }else{
            self.setNeedsDisplay()
        }

    }
    
//    @objc func downdate(link: CADisplayLink){
//        let angle = CGFloat(Double.pi*2.0 / 200.0);
//        d_end_angle = d_end_angle - angle/10
//
//        if d_end_angle < -CGFloat(Double.pi / 2){
//            down = false
//            //終了
//            link.invalidate()
//        } else {
//            self.setNeedsDisplay()
//        }
//    }

    func startAnimating(){
//        down = false
        let displayLink = CADisplayLink(target: self, selector: #selector(self.update))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        up = true
    }
    
//    func decleaseAnimating(){
//        up = false
//        let displayLink = CADisplayLink(target: self, selector: #selector(self.downdate))
//        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
//        down = true
//    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        var x:CGFloat = rect.origin.x;
        x += rect.size.width/2;
        var y:CGFloat = rect.origin.y;
        y += rect.size.height/2;
        var max:CGFloat = 0;
        for dic : Dictionary<String,AnyObject> in _params {
            let value = CGFloat(dic["value"] as! Float)
            max += value;
        }
        
        
        var start_angle:CGFloat = -CGFloat(Double.pi / 2)
        var end_angle:CGFloat    = 0
        let radius:CGFloat  = x - 10.0
        for dic : Dictionary<String,AnyObject> in _params {
            let value = CGFloat(dic["value"] as! Float)
            end_angle = start_angle + CGFloat(Double.pi*2) * (value/max)
            
            if(end_angle > _end_angle && up) {
                end_angle = _end_angle
            }
            
            
            var color:UIColor = dic["color"] as! UIColor
            
            context.move(to: CGPoint(x: x, y: y))
            context.addArc(center:  CGPoint(x:x,y:y), radius: radius, startAngle: start_angle, endAngle: end_angle, clockwise: false)
//            AddArc(context, x, y, radius,  start_angle, end_angle, 0);
            //ここのコメントアウトを解除すると、中くりぬき
            context.addArc(center: CGPoint(x:x,y:y), radius: radius/2, startAngle: end_angle, endAngle: start_angle, clockwise: true)//context, x, y, radius/2,  end_angle, start_angle, 1);
            context.setFillColor((self.tintColor.cgColor))
            context.closePath();
            context.fillPath();
            start_angle = end_angle;
        }
        
    }
        
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
