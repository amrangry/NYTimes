//
//  MostViwedViewModel.swift
//  NYTimes
//
//  Created by Amr ELghadban on 7/1/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

protocol MostViewedViewModelDelegate: class {
}

class MostViwedViewModel: NSObject {
    weak var delegate: MostViewedViewModelDelegate?
}
