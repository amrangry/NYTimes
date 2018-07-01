//
//  MediaMetadata.swift
//  NYTimes
//
//  Created by Amr ELghadban on 7/1/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

struct MediaMetadata: Codable {
    let url: String?
    let format: Format?
    let height, width: Int?
}
