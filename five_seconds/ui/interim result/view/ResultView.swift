//
//  ResultView.swift
//  5second
//
//  Created by Vlad on 16.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    fileprivate let strokeEndTimingFunction   = CAMediaTimingFunction(controlPoints: 1.00, 0.0, 0.35, 1.0)
    fileprivate let squareLayerTimingFunction      = CAMediaTimingFunction(controlPoints: 0.25, 0.0, 0.20, 1.0)
    fileprivate let circleLayerTimingFunction   = CAMediaTimingFunction(controlPoints: 0.65, 0.0, 0.40, 1.0)
    fileprivate let fadeInSquareTimingFunction = CAMediaTimingFunction(controlPoints: 0.15, 0, 0.85, 1.0)
    let kAnimationDuration: TimeInterval = 3.0
    let kAnimationDurationDelay: TimeInterval = 0.5
    let kAnimationTimeOffset: CFTimeInterval = 0.35 * 3.0
    let kRippleMagnitudeMultiplier: CGFloat = 0.025
    var beginTime: CFTimeInterval = 0
    
    func showResult(for result: GameResult) {
        layer.sublayers = nil
        
        var x: CGFloat = 20
        let space: CGFloat = 10
        let columnWidth = (bounds.width - space * CGFloat(result.players.count) - CGFloat(2) * x) / CGFloat(result.players.count)
        let columnHeightSpan = (bounds.height - CGFloat(40)) / CGFloat(10)
        
        for index in 0..<result.players.count {
            let color = UIColor.red
            
            let _layer: CAShapeLayer = CAShapeLayer()
            
            let height: CGFloat = columnHeightSpan * CGFloat(result.players[index].result)
            let y: CGFloat = frame.height - height

            let start = UIBezierPath(rect: CGRect(x: x, y: y, width: columnWidth, height: 0))
            let end = UIBezierPath(rect: CGRect(x: x, y: y, width: columnWidth, height: height))
            
            _layer.fillColor = color.cgColor
            _layer.strokeColor = color.cgColor
            _layer.backgroundColor = UIColor.clear.cgColor
            
            let animation = self.animation(start: start.cgPath, end: end.cgPath)
            _layer.add(animation, forKey: "animation")
            layer.addSublayer(_layer)
            
            x += columnWidth + space
        }
    }
    
    private func animation(start: CGPath, end: CGPath) -> CAAnimation {
        //animation
        let startTimeOffset = 0.7 * kAnimationDuration
        
        let lineWidthAnimation = CAKeyframeAnimation(keyPath: "path")
        lineWidthAnimation.values = [start, end]
        lineWidthAnimation.timingFunctions = [strokeEndTimingFunction, circleLayerTimingFunction]
        lineWidthAnimation.duration = kAnimationDuration
        lineWidthAnimation.keyTimes = [0.0, 1.0]
        
        let animation = CAAnimationGroup()
        animation.repeatCount = 2//Float.infinity
        animation.isRemovedOnCompletion = false
        animation.duration = kAnimationDuration
        animation.beginTime = beginTime
        animation.animations = [lineWidthAnimation]
        animation.timeOffset = startTimeOffset
        
        return animation
    }
}
