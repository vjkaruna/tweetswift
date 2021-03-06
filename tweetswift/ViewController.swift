//
//  ViewController.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/25/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginAction(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                User.currentUser = user
                self.performSegueWithIdentifier("hamburgerLoginSegue", sender: self)
            } else {
                // handle error
            }
        }
    }

}

