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

    let resultColumnColors = [UIColor.red, UIColor.blue, UIColor.cyan, UIColor.brown, UIColor.darkGray]
    
    func showResult(for result: GameResult) {
        layer.sublayers = nil
        
        var x: CGFloat = 20
        let space: CGFloat = 10
        let columnWidth = (bounds.width - space * CGFloat(result.players.count) - CGFloat(2) * x) / CGFloat(result.players.count)
        let columnHeightSpan = (bounds.height - CGFloat(10) - columnWidth) / CGFloat(10)
        
        for index in 0..<result.players.count {
            let color = self.color(for: index)
            
            let _avatarLayer = avatarLayer(for: result.players[index].player, index: index, color: color)
            let _nameLayer = nameLayer(for: result.players[index].player, index: index, color: color)
            let _resultLabelLayer = resultLabelLayer(for: result.players[index].result)
            let _resultLayer: CAShapeLayer = CAShapeLayer()
            
            let height: CGFloat = columnHeightSpan * CGFloat(result.players[index].result)
            let y: CGFloat = frame.height - height

            let start = UIBezierPath(rect: CGRect(x: x, y: 0, width: columnWidth, height: 0))
            let end = UIBezierPath(rect: CGRect(x: x, y: 0, width: columnWidth, height: height))
            
            let avatarLayerStartY: CGFloat = (frame.height - columnWidth - 10)
            let avatarLayerEndY: CGFloat = (y - columnWidth - 10)
            _avatarLayer.frame = CGRect(x: x, y: avatarLayerEndY, width: columnWidth, height: columnWidth)
            
            let nameLayerStartY: CGFloat = (frame.height - 10)
            let nameLayerEndY: CGFloat = (y - 10)
            _nameLayer.frame = CGRect(x: x, y: nameLayerEndY, width: columnWidth, height: 15)
            
            _resultLabelLayer.frame = CGRect(x: x, y: (frame.height - 20), width: columnWidth, height: 15)
            
            _resultLayer.fillColor = color.cgColor
            _resultLayer.strokeColor = UIColor.clear.cgColor
            _resultLayer.backgroundColor = UIColor.clear.cgColor
            _resultLayer.path = UIBezierPath(rect: CGRect(x: x, y: y, width: columnWidth, height: height)).cgPath
            
            let animation = self.resultAnimation(startPath: start.cgPath, endPath: end.cgPath, startY: frame.height, endY: y)
            _resultLayer.add(animation, forKey: "resultanimation")
            
            let avatarAnimation = self.avatarAnimation(start: avatarLayerStartY, end: avatarLayerEndY)
            _avatarLayer.add(avatarAnimation, forKey: "avataranimation")
            
            let nameAnimation = self.nameAnimation(start: nameLayerStartY, end: nameLayerEndY)
            _nameLayer.add(nameAnimation, forKey: "nameAnimation")
            
            layer.addSublayer(_resultLayer)
            layer.addSublayer(_avatarLayer)
            layer.addSublayer(_nameLayer)
            layer.addSublayer(_resultLabelLayer)
            
            x += columnWidth + space
        }
    }
    
    // color
    private func color(for index: Int) -> UIColor {
        if index < resultColumnColors.count {
            return resultColumnColors[index]
        } else {
            var newIndex = index
            while newIndex > resultColumnColors.count {
                newIndex = index - resultColumnColors.count
            }
            guard newIndex < resultColumnColors.count else { return resultColumnColors[0] }
            
            return resultColumnColors[newIndex]
        }
    }
    
    // animations
    private func resultAnimation(startPath: CGPath, endPath: CGPath, startY: CGFloat, endY: CGFloat) -> CAAnimationGroup {
        let basicAnimation1 = CABasicAnimation(keyPath: "path")
        basicAnimation1.fromValue = startPath
        basicAnimation1.toValue = endPath
        basicAnimation1.duration = animationDuration
        basicAnimation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let basicAnimation2 = CABasicAnimation(keyPath: "position.y")
        basicAnimation2.fromValue = startY
        basicAnimation2.toValue = endY
        basicAnimation2.duration = animationDuration
        basicAnimation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.animations = [basicAnimation1, basicAnimation2]
        group.repeatCount = 1
        group.isRemovedOnCompletion = false
        group.duration = animationDuration

        return group
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
    
    // layers
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
        _layer.font = UIFont(name: "Helvetica Neue Light", size: 12)
        _layer.fontSize = 12
        _layer.foregroundColor = UIColor.white.cgColor
        _layer.backgroundColor = UIColor.clear.cgColor
        _layer.alignmentMode = "center"
        _layer.display()
        
        return _layer
    }
    
    private func resultLabelLayer(for result: Int) -> CATextLayer {
        let _layer = CATextLayer()
        _layer.string = String(result)
        _layer.font = UIFont(name: "Helvetica Neue Light", size: 24)
        _layer.fontSize = 24
        _layer.foregroundColor = UIColor.white.cgColor
        _layer.backgroundColor = UIColor.clear.cgColor
        _layer.alignmentMode = "center"
        _layer.display()
        
        return _layer
    }
}
