//
//  NewsItem.swift
//  FB Workshop
//
//  Created by Adithya Narasinghe on 10/4/18.
//  Copyright © 2018 DevCColombo. All rights reserved.
//

import Foundation
import Alamofire

class NewsItem {
    private static let kSource = "source"
    private static let kAuthor = "author"
    private static let kTitle = "title"
    private static let kDescription = "description"
    private static let kUrl = "url"
    private static let kImage = "urlToImage"
    private static let kDate = "publishedAt"
    
    var source: NewsSource
    var author: String
    var title: String
    var description: String
    var url: String
    var image: String
    var date: Date
    
    init?(json: [String:Any]?) {
        if json == nil {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let source = NewsSource(json: json![NewsItem.kSource] as? [String: Any]),
            let author = json![NewsItem.kAuthor] as? String,
            let title = json![NewsItem.kTitle] as? String,
            let description = json![NewsItem.kDescription] as? String,
            let url = json![NewsItem.kUrl] as? String,
            let image = json![NewsItem.kImage] as? String,
            let date = dateFormatter.date(from: json![NewsItem.kDate] as? String ?? "")
            else {
                return nil
        }
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.image = image
        self.date = date
    }
    
    static func getArray(json: [[String: Any]]?) -> [NewsItem]? {
        if json == nil {
            return nil
        }
        
        var result: [NewsItem] = []
        for item in json! {
            if let parsedItem = NewsItem(json: item) {
                result.append(parsedItem)
            }
        }
        return result
    }
    
    static func getNews(forInterest interest: String, handler: @escaping (_ error: Bool, _ data: [NewsItem]?) -> Void) {
        Alamofire.request("https://newsapi.org/v2/everything?q=\(interest)&apiKey=dcdaa5716a0c46a09818607ff045096f").responseString { (returnData) in
            if let json = try? JSONSerialization.jsonObject(with: returnData.data!, options: []) as? [String: Any] {
                handler(false, NewsItem.getArray(json: json?["articles"] as? [[String: Any]]))
            }
            handler(true, [])
        }
    }
    
}

class NewsSource {
    private static let kId = "id"
    private static let kName = "name"
    
    var id: String
    var name: String
    
    init?(json: [String:Any]?) {
        if json == nil {
            return nil
        }
        guard let id = json![NewsSource.kId] as? String,
            let name = json![NewsSource.kName] as? String
            else {
                return nil
        }
        self.id = id
        self.name = name
    }
    
}
