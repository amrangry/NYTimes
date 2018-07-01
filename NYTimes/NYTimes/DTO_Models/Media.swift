//
//  Media.swift
//  NYTimes
//
//  Created by Amr ELghadban on 7/1/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

struct Media: Codable {
    let type: String?
    let subtype: String?
    let caption, copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}
