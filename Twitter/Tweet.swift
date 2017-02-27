//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 2/20/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var userImage : URL?
    var name : String?
    var userDict : NSDictionary
    var time: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        userDict = (dictionary["user"] as? NSDictionary)!
        
        name = userDict["name"] as? String
        let profileUrlString = userDict["profile_image_url_https"] as? String
        userImage = URL(string: profileUrlString!)
        
        /*
        name = dictionary.value(forKey: "user.name") as? String
        
        let profileUrlString = dictionary.value(forKey: "user.profile_image_url") as? String
        if let profileUrlString = profileUrlString {
            userImage = URL(string: profileUrlString)
        }*/
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString)
            
            // reform date
            formatter.dateFormat = "MM/d/YYYY"
            time = formatter.string(from: timeStamp!)
        }
    }
 
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
    }
}
