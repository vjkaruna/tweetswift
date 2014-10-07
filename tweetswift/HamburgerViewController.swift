//
//  HamburgerViewController.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 10/6/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    var sb = UIStoryboard(name: "Main", bundle: nil)

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentCenterCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        loadTimeline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func swipeGesture(sender: UISwipeGestureRecognizer) {
        println("Swiped")
        if (sender.state == .Ended) {
            UIView.animateWithDuration(0.35, animations: {
              self.contentCenterCons.constant = -160
              self.view.layoutIfNeeded()
            })
        }
    }
    @IBAction func profileTouch(sender: AnyObject) {
        if (sender.tag == 601) {
            loadProfile()
        } else if (sender.tag == 602) {
            loadTimeline()
        } else {
            loadTimelineOrMentions(true)
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
    
    func closeHamburger() {
        UIView.animateWithDuration(0.35, animations: {
            self.contentCenterCons.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func loadTimeline() {
        loadTimelineOrMentions(false)
    }
    
    func loadTimelineOrMentions(load_mentions: Bool) {
        println("load timeline in content view")
        var uvc = sb.instantiateViewControllerWithIdentifier("TweetsViewController") as UIViewController
        var vc = uvc as TweetsViewController
        vc.load_mentions = load_mentions
        var nvc = sb.instantiateViewControllerWithIdentifier("navigationController") as UINavigationController
        nvc.pushViewController(vc, animated: false)
        self.addChildViewController(nvc)
        nvc.view.frame = self.contentView.bounds
        self.contentView.addSubview(nvc.view)
        nvc.didMoveToParentViewController(self)
        closeHamburger()
    }
    
    func loadProfile() {
        println("load profile in content view")
        //var vc = sb.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
        var uvc = sb.instantiateViewControllerWithIdentifier("ProfileViewController") as UIViewController
        var vc = uvc as ProfileViewController
        vc.user = User.currentUser
        var nvc = sb.instantiateViewControllerWithIdentifier("navigationController") as UINavigationController
        nvc.pushViewController(vc, animated: false)
        self.addChildViewController(nvc)
        nvc.view.frame = self.contentView.bounds
        self.contentView.addSubview(nvc.view)
        nvc.didMoveToParentViewController(self)
        closeHamburger()
    }

}
