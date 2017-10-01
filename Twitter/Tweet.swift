//
//  Tweet.swift
//  Twitter
//
//  Created by Nanxi Kang on 9/29/17.
//  Copyright © 2017 Nanxi Kang. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    var text: String?
    var createdAt: String?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    
    var favorited: Bool = false
    var author: User?
    
    init(dict: NSDictionary) {
        let userDictOpt = dict["user"] as? NSDictionary
        if let userDict = userDictOpt {
            self.author = User(dict: userDict)
        }
        
        self.text = dict["text"] as? String
        self.createdAt = dict["created_at"] as? String
        self.retweetCount = dict["retweet_count"] as? Int ?? 0
        self.favoriteCount = dict["favourites_count"] as? Int ?? 0
        self.favorited = dict["favorited"] as? Bool ?? false
    }
    
    init(copyFrom: Tweet) {
        self.text = copyFrom.text
        if let user = copyFrom.author {
            self.author = User(copyFrom: user)
        }
        self.createdAt = copyFrom.createdAt
        self.retweetCount = copyFrom.retweetCount
        self.favoriteCount = copyFrom.favoriteCount
        self.favorited = copyFrom.favorited
    }
    
    func toString() -> String {
        return "text: \(self.text),\n createdAt: \(self.createdAt),\n retweetCount: \(self.retweetCount),\n favoriteCount: \(self.favoriteCount),\n favorited: \(self.favorited),\n author: \(self.author?.toString())\n"
    }
    
    class func tweets(fromArray dicts: [NSDictionary]) -> [Tweet] {
        return dicts.map {(dict: NSDictionary) -> Tweet in
            Tweet(dict: dict)
        }
    }
    
}
