//
//  StoryboardList.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

enum StoryboardList: String {
    case navigation = "GameNavigation"
    case menu = "MenuViewController"
    case gamerList = "GamerListViewController"
    case game = "GameViewController"
    case gameMap = "GameMapViewController"
    case interimResult = "InterimResultViewController"
    case finalResult = "FinalResultViewController"
}

protocol StoryboardInstanceable {
    static var storyboardName: StoryboardList {get set}
}

extension StoryboardInstanceable {
    static var storyboardInstance: Self? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:String(describing: self)) as? Self
        return vc
    }
}
