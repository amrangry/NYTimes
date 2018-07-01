//
//  MasterCustomTableViewCell.swift
//  NYTimes
//
//  Created by Amr ELghadban on 6/30/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Kingfisher
import UIKit

class MasterCustomTableViewCell: UITableViewCell {
    @IBOutlet var thumbnilImageView: UIImageView!
    @IBOutlet var activityThumbNilLoader: UIActivityIndicatorView!
    @IBOutlet var title: UILabel!
    @IBOutlet var byWriter: UILabel!
    @IBOutlet var publishedDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnilImageView.layer.borderColor = UIColor(red: 227 / 255, green: 227 / 255, blue: 229 / 255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(object: Displayable) {
        guard let mostViewed = object as? MostViewed else {
            return
        }

        title.text = mostViewed.title
        if let writer = mostViewed.byline {
            byWriter.text = "🖋️ " + writer
        }

        if let date = mostViewed.publishedDate {
            publishedDate.text = "🗓 " + date
        }

        guard let imageURLString = mostViewed.media?.first?.mediaMetadata?.first?.url, let imageURL = URL(string: imageURLString) else {
            return
        }

        displayImageLoader()
        thumbnilImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: Constants.Theme.defultCellImageName), options: [.transition(.fade(1))], progressBlock: nil) { _, _, _, _ in
            self.dimissImageLoader()
        }
    }

    func dimissImageLoader() {
        DispatchQueue.main.async { () -> Void in
            self.activityThumbNilLoader.stopAnimating()
            self.activityThumbNilLoader.isHidden = true
        }
    }

    func displayImageLoader() {
        DispatchQueue.main.async { () -> Void in
            self.activityThumbNilLoader.startAnimating()
            self.activityThumbNilLoader.isHidden = false
        }
    }
}
