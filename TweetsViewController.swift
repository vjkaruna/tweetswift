//
//  TweetsViewController.swift
//  
//
//  Created by Vijay Karunamurthy on 9/29/14.
//
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tweetsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tweetsTable.reloadData()
        })
        
        self.navigationItem.title = "Home"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutAction(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tweets == nil) {
            return 0
        } else {
            return tweets!.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let opcell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as UITableViewCell?
        if (opcell == nil) {
            println("couldn't get reusable cell")
            return UITableViewCell()
        }
        var cell = opcell!
        let tweet = tweets![indexPath.row]
        let thumbnail: UIImageView = cell.viewWithTag(101) as UIImageView
        let nameLabel: UILabel = cell.viewWithTag(102) as UILabel
        let userLabel: UILabel = cell.viewWithTag(103) as UILabel
        let dateLabel: UILabel = cell.viewWithTag(104) as UILabel
        let retweetedSymbol: UIImageView = cell.viewWithTag(201) as UIImageView
        let retweetedLabel: UILabel = cell.viewWithTag(202) as UILabel
        
        thumbnail.sd_setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        nameLabel.text = tweet.text
        userLabel.text = tweet.userLabelText
        dateLabel.text = tweet.dateLabelText
        
        if (tweet.retweeted) {
            retweetedLabel.text = "\(tweet.retweeting_user!.name!) retweeted"
        } else {
            retweetedSymbol.hidden = true
            retweetedLabel.hidden = true
        }
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "tweetDetail") {
            let dvc = segue.destinationViewController as TweetDetailController
            let sourcerow = self.tweetsTable.indexPathForSelectedRow()?.row
            if (sourcerow != nil) {
                dvc.tweet = tweets![sourcerow!]
            }
        } else {
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("tweetDetail", sender: self)
    }
    
}
