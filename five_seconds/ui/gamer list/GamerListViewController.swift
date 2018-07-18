//
//  GamerListViewController.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class GamerListViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.addTarget(self, action: #selector(self.cancelButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var addPlayerButton: UIButton! {
        didSet {
            addPlayerButton.addTarget(self, action: #selector(self.addPlayerButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var startGameButton: UIButton! {
        didSet {
            startGameButton.addTarget(self, action: #selector(self.startGameButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            let nib = UINib(nibName: "PlayerCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PlayerCell")
        }
    }
    
    var model: GamerListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.updateUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension GamerListViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .gamerList
}

@objc extension GamerListViewController {
    private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func addPlayerButtonAction() {
        let addPlayerView = NewPlayerAddeterView(frame: .zero)
        
        addPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        let size = mainView.bounds.size
        
        let addPlayerViewConstrains = [addPlayerView.widthAnchor.constraint(equalToConstant: size.width), addPlayerView.heightAnchor.constraint(equalToConstant: size.height), addPlayerView.centerYAnchor.constraint(equalTo: view.centerYAnchor), addPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        
        addPlayerView.addPlayerAction = { [weak self] in
            self?.model.addNewPlayer(with: $0.name, imageKey: $0.imageKey)
        }
        
        addPlayerView.backgroundColor = Colors.mainMenu
        addPlayerView.cornerRadius = 25
        addPlayerView.alpha = 0
        addPlayerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        self.view.addSubview(addPlayerView)
        NSLayoutConstraint.activate(addPlayerViewConstrains)
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
            addPlayerView.alpha = 1
            addPlayerView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    private func startGameButtonAction() {
        
    }
}

extension GamerListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell {
            let index = indexPath.row
            cell.player = model.players[index]
            cell.index = index
            cell.removeAction = { [weak self] in
                self?.model.removePlayer(at: $0)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
