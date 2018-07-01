//
//  UIAlertController+Extensions.swift
//  ADKA
//
//  Created by Amr ELghadban on 6/11/18.
//  Copyright © 2018 Adka. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    func show() {
        DispatchQueue.main.async {
            UIApplication.topVC().present(self, animated: true, completion: nil)
        }
    }

    func show(message: String) {
        self.show(title: "", message: message)
    }

    func show(title: String, message: String) {
        self.title = title
        self.message = message
        //  self.preferredStyle = .alert
        self.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
            switch action.style {
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        self.show()
    }
}
