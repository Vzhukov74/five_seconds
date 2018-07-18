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

    var arcColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
    
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
    }
    
    func setupAnimation() {
        layer.speed = 1

        let beginTime = CACurrentMediaTime() + Double(0.5)

        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
        opacityAnimation.values = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
        opacityAnimation.duration = 0.5


        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [opacityAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        groupAnimation.duration = 0.5
        groupAnimation.repeatCount = 1
        groupAnimation.isRemovedOnCompletion = false

        for index in 0..<6 {
            let circle = makeArc(for: index)

            groupAnimation.beginTime = beginTime + Double(index) * 0.4
            circle.frame = self.bounds
            circle.add(groupAnimation, forKey: "animation")
            layer.addSublayer(circle)
            
        }
    }
    
    private func makeArc(for index: Int) -> CALayer {
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        var lineWidth: CGFloat = 26
        let lineIncrement: CGFloat = 4
        let lineSpace: CGFloat = 24
        var radius = (self.bounds.width / 4)
        
        lineWidth += CGFloat(index) * lineIncrement
        radius += CGFloat(index) * lineSpace + CGFloat(index) * lineWidth
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        let layer: CAShapeLayer = CAShapeLayer()
        
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = arcColor.cgColor
        layer.lineWidth = lineWidth
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = self.bounds
        //layer.opacity = 0
        
        return layer
    }
}
