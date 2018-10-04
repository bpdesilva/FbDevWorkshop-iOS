//
//  UITableViewCell.swift
//  FB Workshop
//
//  Created by Adithya Narasinghe on 10/4/18.
//  Copyright © 2018 DevCColombo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import Kingfisher
import FacebookShare

class NewsTableViewCell: UITableViewCell {
    
    var newsItem: NewsItem!
    
    @IBOutlet var view: MDCCard!
    @IBOutlet weak var imgCover: RoundedImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("NewsTableViewCell", owner: self, options: nil)
        self.addSubview(view)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        self.view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        self.view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
    
        view.cornerRadius = 8
        view.setShadowElevation(.cardResting, for: .normal)
        view.setShadowColor(UIColor.black, for: .normal)
        
        self.imageView?.kf.indicatorType = .activity
        
        self.layoutIfNeeded()
    }
    
    func render(news: NewsItem) {
        self.newsItem = news
        
        self.imgCover.kf.setImage(with: URL(string: news.image)!, options: [.transition(.fade(0.2))])
        self.lblTitle.text = news.title
        self.lblSource.text = "\(news.source.name) - \(news.author)"
        self.lblDate.text = news.date.description
        self.lblDescription.text = news.description
    }

    @IBAction func btnShare_Tap(_ sender: Any) {
        let content = LinkShareContent(url: URL(string: newsItem.url)!, quote: newsItem.title)
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .automatic
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            // Handle share results
        }
        
        try! shareDialog.show()
    }
    
    
}

class RoundedImageView: ImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners([.topLeft, .topRight], radius: 8)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
