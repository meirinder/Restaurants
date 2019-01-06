//
//  RatingView.swift
//  Restaurants
//
//  Created by Savely on 19.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RatingView: UIView {
    
    var percent: CGFloat = CGFloat(integerLiteral: 0)
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(rect: rect)
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        for i in 0..<5{
            drawStar(path: path, x: (rect.size.width/5)*CGFloat(i)+rect.size.height/2, y: (rect.size.height/2),radius: (rect.size.height/2))
        }
        let clipPath: CGPath = path.cgPath
        
        ctx.addPath(clipPath)
        ctx.closePath()
        ctx.fillPath()
        ctx.restoreGState()        
        let width = rect.size.width * percent
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fill(CGRect( x: 0, y: 0, width: width, height: rect.size.height))
        UIColor.green.setFill()
        path.fill()
    }
    
    func drawStar(path: UIBezierPath,x: CGFloat, y: CGFloat, radius: CGFloat, adjustment: CGFloat = 18){
        let points = polygonPointArray(sides: 5, x: x, y: y, radius: radius, adjustment: adjustment)
        let miniPoints = polygonPointArray(sides: 5, x: x, y: y, radius: 2/5*radius-2, adjustment: adjustment - 36)
        var allPoints = [CGPoint]()
        for i in 0..<11 {
            if i%2 == 0{
                allPoints.append(points[i/2])
            }else {
                allPoints.append(miniPoints[i/2])
            }
        }
//        let path = UIBezierPath()
        path.lineWidth = 2.0
        
        path.move(to: allPoints[0])
        for i in 0..<11{
            path.addLine(to: allPoints[i])
        }
        UIColor.white.setStroke()
        path.stroke()
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
