//
//  ResultView.swift
//  5second
//
//  Created by Vlad on 16.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    let animationDuration: CFTimeInterval = 2.5

    func showResult(for result: GameResult) {
        layer.sublayers = nil
        
        var x: CGFloat = 20
        let space: CGFloat = 10
        let columnWidth = (bounds.width - space * CGFloat(result.players.count) - CGFloat(2) * x) / CGFloat(result.players.count)
        let columnHeightSpan = (bounds.height - CGFloat(10) - columnWidth) / CGFloat(10)
        
        for index in 0..<result.players.count {
            let color = UIColor.red
            
            let _avatarLayer = avatarLayer(for: result.players[index].player, index: index, color: color)
            let _nameLayer = nameLayer(for: result.players[index].player, index: index, color: color)
            let _resultLayer = resultLayer(for: result.players[index].result)
            
            let _resultLayer1: CAShapeLayer = CAShapeLayer()
            let _resultLayer2: CAShapeLayer = CAShapeLayer()
            
            let height: CGFloat = columnHeightSpan * CGFloat(result.players[index].result)
            let y: CGFloat = frame.height - height

            let start = UIBezierPath(rect: CGRect(x: x, y: y, width: columnWidth, height: 0))
            let end = UIBezierPath(rect: CGRect(x: x, y: y, width: columnWidth, height: height))
            
            let avatarLayerStartY: CGFloat = (frame.height - columnWidth - 10)
            let avatarLayerEndY: CGFloat = (y - columnWidth - 10)
            _avatarLayer.frame = CGRect(x: x, y: avatarLayerEndY, width: columnWidth, height: columnWidth)
            
            let nameLayerStartY: CGFloat = (frame.height - 10)
            let nameLayerEndY: CGFloat = (y - 10)
            _nameLayer.frame = CGRect(x: x, y: nameLayerEndY, width: columnWidth, height: 15)
            
            _resultLayer.frame = CGRect(x: x, y: (frame.height - 20), width: columnWidth, height: 15)
            
            _resultLayer1.fillColor = color.cgColor
            _resultLayer1.strokeColor = UIColor.clear.cgColor
            _resultLayer1.backgroundColor = UIColor.clear.cgColor
            _resultLayer1.path = end.cgPath
            
            _resultLayer2.fillColor = UIColor.white.cgColor
            _resultLayer2.strokeColor = UIColor.white.cgColor
            _resultLayer2.backgroundColor = UIColor.white.cgColor
            _resultLayer2.path = start.cgPath
            
            let animation = self.animation(start: end.cgPath, end: start.cgPath)
            _resultLayer2.add(animation, forKey: "animation")
            
            let avatarAnimation = self.avatarAnimation(start: avatarLayerStartY, end: avatarLayerEndY)
            _avatarLayer.add(avatarAnimation, forKey: "avataranimation")
            
            let nameAnimation = self.nameAnimation(start: nameLayerStartY, end: nameLayerEndY)
            _nameLayer.add(nameAnimation, forKey: "nameAnimation")
            
            layer.addSublayer(_resultLayer1)
            layer.addSublayer(_resultLayer2)
            layer.addSublayer(_avatarLayer)
            layer.addSublayer(_nameLayer)
            layer.addSublayer(_resultLayer)
            
            x += columnWidth + space
        }
    }
    
    private func animation(start: CGPath, end: CGPath) -> CAAnimation {
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.fromValue = start
        basicAnimation.toValue = end
        basicAnimation.duration = animationDuration
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return basicAnimation
    }
    
    private func avatarAnimation(start: CGFloat, end: CGFloat) -> CAAnimation {
        let basicAnimation = CABasicAnimation(keyPath: "position.y")
        basicAnimation.fromValue = start
        basicAnimation.toValue = end
        basicAnimation.duration = animationDuration
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return basicAnimation
    }
    
    private func nameAnimation(start: CGFloat, end: CGFloat) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(keyPath: "position.y")
        basicAnimation.fromValue = start
        basicAnimation.toValue = end
        basicAnimation.duration = animationDuration
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return basicAnimation
    }
    
    //avatars
    private func avatarLayer(for player: Player, index: Int, color: UIColor) -> CAShapeLayer  {
        let avatar = AvatarStore.avatar(for: player.avatarKey)
        let _layer = CAShapeLayer()
        _layer.contents = avatar.cgImage
        _layer.fillColor = UIColor.blue.cgColor
        
        return _layer
    }
    
    private func nameLayer(for player: Player, index: Int, color: UIColor) -> CATextLayer {
        let _layer = CATextLayer()
        _layer.string = player.name
        _layer.font = UIFont.systemFont(ofSize: 10)
        _layer.fontSize = 10
        _layer.foregroundColor = UIColor.brown.cgColor
        _layer.alignmentMode = "center"
        
        return _layer
    }
    
    private func resultLayer(for result: Int) -> CATextLayer {
        let _layer = CATextLayer()
        _layer.string = String(result)
        _layer.font = UIFont.systemFont(ofSize: 10)
        _layer.fontSize = 10
        _layer.foregroundColor = UIColor.white.cgColor
        _layer.alignmentMode = "center"
        
        return _layer
    }
}
