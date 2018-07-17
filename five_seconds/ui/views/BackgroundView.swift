//
//  BackgroundView.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [#colorLiteral(red: 0.7607843137, green: 0.4862745098, blue: 0.8156862745, alpha: 1).cgColor, #colorLiteral(red: 0.3921568627, green: 0.262745098, blue: 0.7137254902, alpha: 1).cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var lineWidth: CGFloat = 26
        let lineIncrement: CGFloat = 4
        let lineSpace: CGFloat = 24
        var radius = (rect.width / 4)
        let arcColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        
        let path1 = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path1.lineWidth = lineWidth
        arcColor.setStroke()
        path1.stroke()
        
        radius += lineSpace + lineWidth
        lineWidth += lineIncrement

        let path2 = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path2.lineWidth = lineWidth
        arcColor.setStroke()
        path2.stroke()

        radius += lineSpace + lineWidth
        lineWidth += lineIncrement

        let path3 = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path3.lineWidth = lineWidth
        arcColor.setStroke()
        path3.stroke()
        
        radius += lineSpace + lineWidth
        lineWidth += lineIncrement
        
        let path4 = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path4.lineWidth = lineWidth
        arcColor.setStroke()
        path4.stroke()
        
        radius += lineSpace + lineWidth
        lineWidth += lineIncrement
        
        let path5 = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path5.lineWidth = lineWidth
        arcColor.setStroke()
        path5.stroke()
    }
}
