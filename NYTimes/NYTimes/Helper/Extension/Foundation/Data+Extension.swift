//
//  Data+Extension.swift
//  ADKA
//
//  Created by Amr ELghadban on 3/20/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

extension Data {
    static func convertToData(_ obj: Any) -> Data? {
        var data: Data?
        if let jsonString = obj as? String {
            let result = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            data = result
        } else if let jsonArrayOfDic = obj as? [[String: AnyObject]] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonArrayOfDic, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        } else if let jsonDic = obj as? [String: AnyObject] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        }
        return data
    }
}
