//
//  DetailViewController.swift
//  NYTimes
//
//  Created by Amr ELghadban on 6/30/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var thumbnilImageView: UIImageView!
    @IBOutlet var activityThumbNilLoader: UIActivityIndicatorView!
    @IBOutlet var postTitle: UILabel!
    @IBOutlet var publishedDate: UILabel!

    @IBOutlet var postDetails: UILabel!
    @IBOutlet var byWriter: UILabel!

    func bindData(object: Displayable) {
        guard let mostViewed = object as? MostViewed else {
            return
        }

        title = mostViewed.title
        postTitle.text = mostViewed.title
        if let writer = mostViewed.byline {
            byWriter.text = "🖋️ Writer: " + writer
        }

        if let date = mostViewed.publishedDate {
            publishedDate.text = "🗒️ Published : " + date
        }

        if let details = mostViewed.abstract {
            postDetails.text = details
        }

        guard let imageURLString = mostViewed.media?.first?.mediaMetadata?.first?.url, let imageURL = URL(string: imageURLString) else {
            return
        }

        displayImageLoader()
        thumbnilImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: Constants.Theme.defultCellImageName), options: [.transition(.fade(1))], progressBlock: nil) { _, _, _, _ in
            self.dimissImageLoader()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let detail = detailItem {
            bindData(object: detail)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: MostViewed?

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
