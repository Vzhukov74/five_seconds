//
//  AvatarStore.swift
//  5second
//
//  Created by Maximal Mac on 29.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import UIKit

class AvatarStore {
    static let avatarKeys = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    class func avatar(for key: String) -> UIImage {
        return UIImage(named: key) ?? UIImage()
    }
}
