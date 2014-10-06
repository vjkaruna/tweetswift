//
//  TweetsViewController.swift
//  
//
//  Created by Vijay Karunamurthy on 9/29/14.
//
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tweetsTable: UITableView!
    var pullView: PullToRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tweetsTable.reloadData()
        })
        
        self.navigationItem.title = "Home"
        
        var f = CGRectMake(0, 0, self.tweetsTable.bounds.size.width, 1)
        let pullContainer = UIView(frame: f)
        tweetsTable.estimatedRowHeight = 88
        tweetsTable.rowHeight = UITableViewAutomaticDimension
        pullView = UINib(nibName: "PullToRefreshView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as PullToRefreshView
        f.origin.y = -88
        f.size.height = 88
        pullView.frame = f
        pullContainer.addSubview(pullView)
        self.tweetsTable.tableHeaderView = pullContainer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //NSLog("Scrolling to: \(scrollView.contentOffset.y)")
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -pullDistance {
            //NSLog("Would pull")
            pullView.state = .Refreshing
            self.tweetsTable.contentInset = UIEdgeInsets(top: 88.0, left: 0, bottom: 0, right: 0)
            self.tweetsTable.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.pullView.state = .Default
                self.tweetsTable.reloadData()
            })
        } else {
            //NSLog("not far enough")
        }
    }
    
    let pullDistance:CGFloat = 88.0
    

    @IBAction func logoutAction(sender: AnyObject) {
        println("Recevied logout action")
        User.logout()
        
    }
    
    @IBAction func replyAction(sender: AnyObject) {
        println("in reply")
        self.performSegueWithIdentifier("composeSegue", sender: sender)
    }
    
    @IBAction func retweetAction(sender: AnyObject) {
        println("in retweet")
        var rtbutton = sender as UIButton
        rtbutton.selected = true
        var clickedsuper = sender.superview as UIView!
        var clickedCell = clickedsuper.superview as UITableViewCell!
        var indexPath = self.tweetsTable.indexPathForCell(clickedCell) as NSIndexPath!
        var id_str = tweets![indexPath.row].id_str!
        TwitterClient.sharedInstance.nativeRetweet(id_str) { (error) -> () in
            println("Retweeted!")
        }
        
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        var fvbutton = sender as UIButton
        fvbutton.selected = true
        var clickedsuper = sender.superview as UIView!
        var clickedCell = clickedsuper.superview as UITableViewCell!
        var indexPath = self.tweetsTable.indexPathForCell(clickedCell) as NSIndexPath!
        var id_str = tweets![indexPath.row].id_str!
        TwitterClient.sharedInstance.favTweet(id_str) { (error) -> () in
            println("Favorited!")
        }
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
        let nameLabel = cell.viewWithTag(102) as TTTAttributedLabel
        let userLabel: UILabel = cell.viewWithTag(103) as UILabel
        let dateLabel: UILabel = cell.viewWithTag(104) as UILabel
        let retweetedSymbol: UIImageView = cell.viewWithTag(201) as UIImageView
        let retweetedLabel: UILabel = cell.viewWithTag(202) as UILabel
        let favbutton: UIButton = cell.viewWithTag(401) as UIButton
        let rtbutton: UIButton = cell.viewWithTag(402) as UIButton
        
        favbutton.selected = false
        rtbutton.selected = false
        thumbnail.layer.cornerRadius = 8
        thumbnail.layer.masksToBounds = true
        thumbnail.sd_setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        nameLabel.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes
        nameLabel.text = tweet.text
        userLabel.attributedText = tweet.userLabelText
        dateLabel.text = tweet.dateLabelText
        
        var nc = NSLayoutConstraint(item: retweetedSymbol, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: thumbnail, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -8.0)
        
        if (tweet.retweeted) {
            retweetedLabel.text = "\(tweet.retweeting_user!.name!) retweeted"
            retweetedSymbol.hidden = false
            retweetedLabel.hidden = false
            retweetedSymbol.superview!.addConstraint(nc)
            
        } else {
            retweetedSymbol.hidden = true
            retweetedLabel.hidden = true
            retweetedSymbol.superview!.removeConstraint(nc)
            //retweetedLabel.removeConstraints(retweetedLabel.constraints())
            //retweetedSymbol.removeConstraints(retweetedSymbol.constraints())
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
            
            if (sender is UIButton) {
              let cvc = segue.destinationViewController as ComposeController
              var clickedsuper = (sender as UIButton).superview as UIView!
              var clickedCell = clickedsuper.superview as UITableViewCell!
              var indexPath = self.tweetsTable.indexPathForCell(clickedCell) as NSIndexPath!
              cvc.origTweet = tweets![indexPath.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("tweetDetail", sender: self)
    }
    
}
