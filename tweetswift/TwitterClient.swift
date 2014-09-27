//
//  TwitterClient.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/26/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

let twitterConsumerKey = "YqtB50sG5dEEptzoqr3D30v7w"
let twitterConsumerSecret = "dKg1FlIeHWOBwrTML8MlxObvWBBnE1BdUXAe8ccvkg0fA2Elf1"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
            
        return Static.instance
    }
    

}
