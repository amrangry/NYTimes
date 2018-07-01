//
//  JSONDecoderable.swift
//  RealEstate
//
//  Created by Amr ELghadban on 6/14/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

protocol JSONDecoderable {
    static func decodeJsonData<T: Codable>(parcelable: T, _ jsonData: Data, isObject: Bool) -> Any?
}

extension JSONDecoderable where Self: Codable {
    static func decodeJsonData<T: Codable>(parcelable: T, _ jsonData: Data, isObject: Bool) -> Any? {
        do {
            let jsonDecoder = JSONDecoder()
            var result: Any?
            if isObject {
                let object = try jsonDecoder.decode(T.self, from: jsonData)
                result = object
            } else {
                let list = try jsonDecoder.decode([T].self, from: jsonData)
                result = list
            }
            return result
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
