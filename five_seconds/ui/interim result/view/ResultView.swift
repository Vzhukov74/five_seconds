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
        let offset: CGFloat = 24
        let columnWidth = (bounds.width - space * CGFloat(result.players.count) - CGFloat(2) * x) / CGFloat(result.players.count)
        let columnHeightSpan = (bounds.height - CGFloat(34) - columnWidth) / CGFloat(10)
        
        for index in 0..<result.players.count {
            let color = self.color(for: index)
            let columnHeight: CGFloat = columnHeightSpan * CGFloat(result.players[index].result)
            let y: CGFloat = bounds.height - columnHeight - offset
            
            //ResultColumnLayer
            let _resultLayer = ResultColumnLayer(width: columnWidth, height: columnHeight)
            _resultLayer.frame = CGRect(x: x, y: y, width: columnWidth, height: columnHeight)
            _resultLayer.fillColor = color.cgColor
            _resultLayer.strokeColor = UIColor.clear.cgColor
            _resultLayer.backgroundColor = UIColor.clear.cgColor
            layer.addSublayer(_resultLayer)
            _resultLayer.expand()
            
            //ResultLabelLayer
            let _resultLabelLayer = resultLabelLayer(for: result.players[index].result)
            _resultLabelLayer.frame = CGRect(x: x, y: (bounds.height - 25 - offset), width: columnWidth, height: 25)
            layer.addSublayer(_resultLabelLayer)
            
            //AvatarLayer
            let _avatarLayer = avatarLayer(for: result.players[index].player, index: index, color: color)
            let avatarLayerStartY: CGFloat = (bounds.height - columnWidth - 10 - offset)
            let avatarLayerEndY: CGFloat = (y - columnWidth + 5)
            _avatarLayer.frame = CGRect(x: x, y: avatarLayerStartY, width: columnWidth, height: columnWidth)
            let avatarAnimation = self.avatarAnimation(start: avatarLayerStartY, end: avatarLayerEndY)
            _avatarLayer.add(avatarAnimation, forKey: "avataranimation")
            layer.addSublayer(_avatarLayer)
            
            //NameLayer
            let _nameLayer = nameLayer(for: result.players[index].player, index: index, color: color)
            let nameLayerStartY: CGFloat = (bounds.height - 10 - offset)
            let nameLayerEndY: CGFloat = (y - 6)
            _nameLayer.frame = CGRect(x: x, y: nameLayerStartY, width: columnWidth, height: 12)
            let nameAnimation = self.nameAnimation(start: nameLayerStartY, end: nameLayerEndY)
            _nameLayer.add(nameAnimation, forKey: "nameAnimation")
            layer.addSublayer(_nameLayer)
            
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
    private func avatarAnimation(start: CGFloat, end: CGFloat) -> CAAnimation {
        let basicAnimation = CABasicAnimation(keyPath: "position.y")
        basicAnimation.fromValue = start
        basicAnimation.toValue = end
        basicAnimation.duration = animationDuration
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return basicAnimation
    }
    
    private func nameAnimation(start: CGFloat, end: CGFloat) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(keyPath: "position.y")
        basicAnimation.fromValue = start
        basicAnimation.toValue = end
        basicAnimation.duration = animationDuration
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = kCAFillModeForwards
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
        let attributes = [
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 12.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        let attributedString = NSAttributedString(string: player.name, attributes: attributes)
        _layer.string = attributedString
        _layer.alignmentMode = "center"
        _layer.display()
        
        return _layer
    }
    
    private func resultLabelLayer(for result: Int) -> CATextLayer {
        let _layer = CATextLayer()
        let attributes = [
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 18.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        let attributedString = NSAttributedString(string: String(result), attributes: attributes)
        _layer.string = attributedString
        _layer.backgroundColor = UIColor.clear.cgColor
        _layer.alignmentMode = "center"
        _layer.display()
        
        return _layer
    }
}
