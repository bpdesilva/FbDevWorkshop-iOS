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
                    self.animateTable()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }
    
    func setup(interest: String) {
        self.titleStr = interest
    }
    
    func animateTable() {
        tblNews.reloadData()
        let cells = tblNews.visibleCells
        
        let tableViewHeight = tblNews.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    @objc func showDetails(sender: UIView) {
        if let link = URL(string: self.news[sender.tag].url) {
            UIApplication.shared.open(link)
        }
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
        cell.view.tag = indexPath.row
        cell.view.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = URL(string: self.news[indexPath.row].url) {
            UIApplication.shared.open(link)
        }
    }
    
    
}
