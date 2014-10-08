//
//  TwitterClient.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/26/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import Foundation

let twitterConsumerKey = "KCubIEfxcGTPPI1Y1OvqpbS1v"
let twitterConsumerSecret = "kmEKaEzYPwu1C7NxW72baF680DKD3XPzih0q5JfkXV7oL1CAsD"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
            
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)" )
            UIApplication.sharedApplication().openURL(authURL)
            }, failure: { (error: NSError!) -> Void in
                self.showError("Error with Oauth \(error)")
                self.loginCompletion?(user: nil, error: error)
        })
        
    }
    
    func openURL(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) ->
            Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {
                (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("handling response \(response)")
                if (!(response is NSDictionary)) {
                    self.showError("Response is not a dictionary")
                } else {
                    var user = User(dictionary: response as NSDictionary)
                    self.loginCompletion?(user: user, error: nil)
                }
                //println("\(response)")
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.showError("Network error \(operation)")
            })
            
            } , failure: { (nserror: NSError!) -> Void in
                self.showError("Network error")
                self.loginCompletion?(user: nil, error: nserror)
        })
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }
    
    func userTimeline(screenname: String, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/user_timeline.json", parameters: ["screen_name":screenname], success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }
    
    func loadMentions(completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/mentions_timeline.json", parameters: NSDictionary(), success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }
    
    func showUser(screenname: String, completion: (user:User?, error: NSError?) -> ()) {
        GET("1.1/users/show.json", parameters: ["screen_name":screenname], success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var res_user = User(dictionary: response as NSDictionary)
            completion(user:res_user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }
    
    func postTweetWithParams(params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/update.json", parameters: params, success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }

    func nativeRetweet(id_str: String, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id_str).json", parameters: NSDictionary(), success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }
    
    func favTweet(id_str: String, completion: (error: NSError?) -> ()) {
        POST("1.1/favorites/create.json", parameters: ["id":id_str], success: {
            (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.showError("Network error: \(operation)")
        })
    }
    
    func showError(error: String) {
        var contentView = UIView()
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.frame = CGRectMake(0, 0, 200, 300)
        var myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.frame = CGRectMake(5, 5, 195, 295)
        myLabel.text = error
        myLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        contentView.addSubview(myLabel)
        
        
        var popup = KLCPopup(contentView: contentView)
        popup.show()
    }
    
    
}
