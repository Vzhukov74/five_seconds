//
//  InterimResultViewController.swift
//  5second
//
//  Created by Maximal Mac on 27.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class InterimResultViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultView: ResultView!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.addTarget(self, action: #selector(self.nextButtonAction), for: .touchUpInside)
        }
    }
    
    var model: GameResult!
    var currentRound: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Result of \(String(currentRound)) round!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultView.showResult(for: model)
    }
    
    deinit {
        print("deinit - InterimResultViewController")
    }
}

extension InterimResultViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .interimResult
}

@objc extension InterimResultViewController {
    private func nextButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}
