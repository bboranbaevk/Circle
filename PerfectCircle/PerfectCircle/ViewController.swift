//
//  ViewController.swift
//  PerfectCircle
//
//  Created by Бекбол Боранбаев on 26.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            drawCircle(at: location)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            eraseCircles()
            drawCircle(at: location)
        }
    }
    private func eraseCircles() {
        for circle in circles {
            circle.removeFromSuperview()
        }
        circles.removeAll()
    }

    
    private func drawCircle(at location: CGPoint) {
        let circleSize: CGFloat = 50.0
        let circle = UIView(frame: CGRect(x: location.x - circleSize/2, y: location.y - circleSize/2, width: circleSize, height: circleSize))
        circle.layer.cornerRadius = circleSize/2
        circle.backgroundColor = UIColor.red
        
        self.view.addSubview(circle)
        circles.append(circle)
    }

    
    

    
    var circles: [UIView] = []

}
