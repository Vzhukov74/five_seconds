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
    var startGame: ((_ vc: UIViewController) -> Void)?
    var didDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.updateUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func startGame(with vc: UIViewController) {
        dismiss(animated: true) { [weak self] in
            self?.startGame?(vc)
        }
    }
    
    private func showAlert() {
        let alert = AlertView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 120)))
        alert.clipsToBounds = true
        alert.cornerRadius = 25
        alert.backgroundColor = UIColor.lightGray
        alert.show(on: mainView, with: "For game needed minimum two players!")
    }
}

extension GamerListViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .gamerList
}

@objc extension GamerListViewController {
    private func cancelButtonAction() {
        didDismiss?()
        dismiss(animated: true, completion: nil)
    }
    
    private func addPlayerButtonAction() {
        let addPlayerView = NewPlayerAddeterView(frame: .zero)
        
        addPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        let size = mainView.bounds.size
        
        let addPlayerViewConstrains = [addPlayerView.widthAnchor.constraint(equalToConstant: size.width), addPlayerView.heightAnchor.constraint(equalToConstant: size.height), addPlayerView.centerYAnchor.constraint(equalTo: view.centerYAnchor), addPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        
        addPlayerView.addPlayerAction = { [weak self] (name, imageKey) in
            self?.model.addNewPlayer(with: name, imageKey: imageKey)
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
        let players = model.chosenPlayers()
        if players.count > 1 {
            if let vc = GameViewController.storyboardInstance {
                let provider = QuestionProviderEngine()
                let engine = GameEngine(questionProvider: provider, timerTime: 5)
                vc.model = GameModel(players: players, engine: engine)
                startGame(with: vc)
            }
        } else {
            showAlert()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlayerCell {
            cell.toggle()
        }
    }
}
