//
//  RatingView.swift
//  Restaurants
//
//  Created by Savely on 19.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RatingView: UIView {
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        
        
        let path = UIBezierPath(rect: rect)    //UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()

        drawStar()


    }
    
    func drawStar(){
        let points = polygonPointArray(sides: 5, x: 80, y: 80, radius: 80, adjustment: 18)
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: points[0])
        var index = 0
        for _ in 0..<5{
            index += 3
            index %= 5
            plusPath.addLine(to: points[index])
        }
        UIColor.white.setStroke()
        plusPath.stroke()
    }

    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(Double.pi) * a/180
        return b
    }
    
    func polygonPointArray(sides: Int, x: CGFloat, y: CGFloat, radius: CGFloat, adjustment: CGFloat=0) -> [CGPoint] {
        let angle = degree2radian(a: 360/CGFloat(sides))
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = x - radius * cos(angle * CGFloat(i)+degree2radian(a: adjustment))
            let ypo = y - radius * sin(angle * CGFloat(i)+degree2radian(a: adjustment))
            points.append(CGPoint(x: xpo, y: ypo))
            i -= 1
        }
        return points
    }
    
    
}
