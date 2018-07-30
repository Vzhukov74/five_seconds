//
//  GameQuestionView.swift
//  5second
//
//  Created by Maximal Mac on 30.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class GameQuestionView: UIView {
    @IBOutlet var contentView: UIView! {
        didSet {
           contentView.backgroundColor = .clear 
        }
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("GameQuestionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
