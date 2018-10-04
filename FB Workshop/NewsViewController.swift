//
//  NewsViewController.swift
//  FB Workshop
//
//  Created by Adithya Narasinghe on 10/4/18.
//  Copyright © 2018 DevCColombo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class NewsViewController: UIViewController {
    
    var news: [NewsItem] = []
    var titleStr = ""
    
    @IBOutlet weak var tblNews: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNews.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsItem")
        tblNews.delegate = self
        tblNews.dataSource = self
        self.title = self.titleStr
        NewsItem.getNews(forInterest: titleStr) { (error, news) in
            if news != nil && news!.count > 0 {
                self.news = news!
                if self.tblNews != nil {
                    self.tblNews.reloadData()
                }
            }
        }
    }
    
    func setup(interest: String) {
        self.titleStr = interest
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItem",
                                                      for: indexPath) as! NewsTableViewCell
        cell.render(news: self.news[indexPath.row])
        return cell
    }
    
    
}
