//
//  ProgressLoader.swift
//  RealEstate
//
//  Created by Amr ELghadban on 6/14/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

class ProgressLoader: NSObject {
    static func show() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    static func dismiss() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
