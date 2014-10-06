//
//  TweetDetailController.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/30/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit

class TweetDetailController: UIViewController {
    
    var tweet: Tweet?

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetBody: TTTAttributedLabel!
    @IBOutlet weak var date: UILabel!
    
    @IBAction func replyAction(sender: AnyObject) {
        self.performSegueWithIdentifier("composeDetailSegue", sender: sender)
    }
    @IBAction func retweetAction(sender: AnyObject) {
        println("in retweet")
        var rtbutton = sender as UIButton
        rtbutton.selected = true
        var id_str = tweet!.id_str!
        TwitterClient.sharedInstance.nativeRetweet(id_str) { (error) -> () in
            println("Retweeted!")
        }
    }
    @IBAction func favoriteAction(sender: AnyObject) {
        var fvbutton = sender as UIButton
        fvbutton.selected = true
        var id_str = tweet!.id_str!
        TwitterClient.sharedInstance.favTweet(id_str) { (error) -> () in
            println("Favorited!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println("\(tweet!.text)")
        
        self.avatar.sd_setImageWithURL(NSURL(string:tweet!.user!.profileImageUrl!))
        self.tweetBody.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes
        self.tweetBody.text = tweet!.text
        self.date.text = tweet!.dateLabelText
        self.username.attributedText = tweet!.userLabelText
        
        /** let replyBtn = self.navigationController?.navigationBar.viewWithTag(901) as UIBarButtonItem
        replyBtn.title = "Reply"
        **/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
