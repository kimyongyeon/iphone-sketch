//
//  ViewController.swift
//  SketchApp
//
//  Created by p151541 on 2020/08/04.
//  Copyright © 2020 p151541. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtStroke: UITextField!
    var lastPoint: CGPoint!
    var lineSize:CGFloat = 2.0
    var lineColor = UIColor.red.cgColor
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func clearImageView(_ sender: Any) {
        imgView.image = nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고 옵니다.
        lastPoint = touch.location(in: imgView) // 터치된 위치를 lastPoint라는 변수에 저장합니다.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드로 설정합니다.
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고 옵니다.
        let currentPoint = touch.location(in: imgView) // 터치된 위치를 currPoint 로 가지고 옵니다.
        
        imgView.image?.draw(in: CGRect(x: 0, y:0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지 뷰(imageView)에 있는 이미지를 이미지뷰(image view)의 크기로 그립니다.
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킵니다.
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y)) // lastPoint에서 현재 위치인 currPoint까지 선을 추가 합니다.
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint // 현재 터치된 위치를 lastPoint라는 변수에 할당합니다.
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         UIGraphicsBeginImageContext(imgView.frame.size)
         UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor) // 선의 색상
         UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드로 설정합니다.
         UIGraphicsGetCurrentContext()?.setLineWidth(lineSize) // 선 굵기
        
        imgView.image?.draw(in: CGRect(x: 0, y:0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지 뷰(imageView)에 있는 이미지를 이미지뷰(image view)의 크기로 그립니다.
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킵니다.
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // lastPoint에서 현재 위치인 currPoint까지 선을 추가 합니다.
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgView.image = nil
        }
    }

    @IBAction func changeTxtStroke(_ sender: UITextField) {
        if let n = NumberFormatter().number(from: txtStroke.text ?? "0") {
            let f = CGFloat(truncating: n)
            lineSize = CGFloat(f)
        }
        
    }
    @IBAction func btnBlue(_ sender: Any) {
        // 블루
        lineColor = UIColor.blue.cgColor
    }
    @IBAction func btnGreen(_ sender: Any) {
        // 그린
        lineColor = UIColor.green.cgColor
    }
    @IBAction func btnRed(_ sender: Any) {
        // 레드
        lineColor = UIColor.red.cgColor
    }
    @IBAction func btnBlack(_ sender: Any) {
        // 블랙
        lineColor = UIColor.black.cgColor
    }
}

