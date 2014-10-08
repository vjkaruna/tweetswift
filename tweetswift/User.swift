//
//  User.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/29/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"
let userTimelineNotification = "userTimelineNotification"
let textFont = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 12.0)]
let boldFont = [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 12.0)]

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var profileBackgroundImageUrl: String?
    var bio: String?
    var followersCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    

    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        //println("Confirm user \(dictionary)")
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        profileBackgroundImageUrl = dictionary["profile_background_image_url"] as? String
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        bio = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
    }
    
    class func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        println("posting logout notification")
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            println("in current user get")
            if (_currentUser == nil) {
                println("_currentUser is nil")
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    println("data is not nil")
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            println("in current user set")
            _currentUser = user
            
            if (user != nil) {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                println("current user setting nil")
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    lazy var userLabelText: NSMutableAttributedString = {
        let descText = NSMutableAttributedString()
        
        descText.appendAttributedString(NSAttributedString(string: "\(self.name!)",attributes:boldFont))
        descText.appendAttributedString(NSAttributedString(string: " @\(self.screenname!)",attributes:textFont))
        return descText
    }()
    
    lazy var followingText: NSMutableAttributedString = {
        let descText = NSMutableAttributedString()
        
        descText.appendAttributedString(NSAttributedString(string: "\(self.followingCount!)",attributes:boldFont))
        descText.appendAttributedString(NSAttributedString(string: " Following",attributes:textFont))
        return descText
    }()
    
    lazy var followersText: NSMutableAttributedString = {
        let descText = NSMutableAttributedString()
        
        descText.appendAttributedString(NSAttributedString(string: "\(self.followersCount!)",attributes:boldFont))
        descText.appendAttributedString(NSAttributedString(string: " Followers",attributes:textFont))
        return descText
    }()
    
    
    lazy var tweetCountText: NSMutableAttributedString = {
        let descText = NSMutableAttributedString()
        
        descText.appendAttributedString(NSAttributedString(string: "\(self.tweetCount!)",attributes:boldFont))
        descText.appendAttributedString(NSAttributedString(string: " Tweets",attributes:textFont))
        return descText
    }()
    
}
