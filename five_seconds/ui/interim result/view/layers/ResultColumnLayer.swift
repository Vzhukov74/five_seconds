//
//  ResultColumnLayer.swift
//  5second
//
//  Created by Maximal Mac on 28.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class ResultColumnLayer: CAShapeLayer {
    let animationDuration: CFTimeInterval = 0.9
    
    private(set) var _width: CGFloat
    private(set) var _height: CGFloat
    
    var startPath: UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 0, y: _height, width: _width, height: 0))
    }
    
    var endPath: UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 0, y: 0, width: _width, height: _height))
    }
    
    init(width: CGFloat, height: CGFloat) {
        self._width = width
        self._height = height
        
        super.init()
        
        self.path = UIBezierPath(rect: CGRect(x: 0, y: height, width: width, height: 0)).cgPath
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func expand() {
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = startPath.cgPath
        expandAnimation.toValue = endPath.cgPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        add(expandAnimation, forKey: nil)
    }
}
