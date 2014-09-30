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
    @IBOutlet weak var tweetBody: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("\(tweet!.text)")
        
        self.avatar.sd_setImageWithURL(NSURL(string:tweet!.user!.profileImageUrl!))
        self.tweetBody.text = tweet!.text
        self.date.text = tweet!.dateLabelText
        self.username.text = tweet!.userLabelText
        
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
