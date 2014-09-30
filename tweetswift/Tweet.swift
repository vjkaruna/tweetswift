//
//  Tweet.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/29/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweeted = false
    var retweeting_user: User?
    
    
    init(json_dict: NSDictionary) {
        
        var dictionary = json_dict
        var retweeted_status = dictionary["retweeted_status"] as? NSDictionary
        if (retweeted_status != nil) {
            retweeted = true
            retweeting_user = User(dictionary: dictionary["user"] as NSDictionary)
            dictionary = retweeted_status!
        }
        
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(json_dict: dictionary))
        }
        
        return tweets
    }
    
    var userLabelText: String {
        return "\(self.user!.name!) @\(self.user!.screenname!)"
    }
    
    var dateLabelText: String {
        return "\(createdAtString!)"
    }
    
}
