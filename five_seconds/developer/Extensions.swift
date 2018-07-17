//
//  extensions.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
