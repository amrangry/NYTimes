//
//  UIImageVIew+Extension.swift
//  ADKA
//
//  Created by Amr ELghadban on 6/13/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill, completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                completionHandler(false)
                return
            }

            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else {
                completionHandler(false)
                return
            }
            guard let data = data, error == nil else {
                completionHandler(false)
                return
            }
            guard let image = UIImage(data: data)
            else {
                completionHandler(false)
                return
            }
            DispatchQueue.main.async { () -> Void in
                completionHandler(true)
                self.image = image
            }
        }.resume()
    }

    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        guard let url = URL(string: link) else {
            completionHandler(false)
            return
        }
        downloadedFrom(url: url, contentMode: mode) { status in
            completionHandler(status)
        }
    }
}
