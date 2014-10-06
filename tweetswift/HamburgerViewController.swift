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
            contentCenterCons.constant = -160
        }
    }
    @IBAction func profileTouch(sender: AnyObject) {
        if (sender.tag == 601) {
            loadProfile()
        } else {
            loadTimeline()
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
        contentCenterCons.constant = 0
    }
    
    func loadTimeline() {
        println("load timeline in content view")
        var vc = sb.instantiateViewControllerWithIdentifier("TweetsViewController") as UIViewController
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
