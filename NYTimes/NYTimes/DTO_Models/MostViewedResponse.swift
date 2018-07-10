//
//  MostViewedResponse.swift
//  NYTimes
//
//  Created by Amr ELghadban on 7/1/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

struct MostViewedResponse: Codable, JSONDecoderable, Displayable {
    let status, copyright: String?
    let numResults: Int?
    let results: [MostViewed]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}
