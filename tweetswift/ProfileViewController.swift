//
//  ProfileViewController.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 10/6/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (self.user == nil) {
            println("loading current user for profile")
            self.user = User.currentUser
        }
        println("user \(self.user)")
        background.sd_setImageWithURL(NSURL(string: self.user!.profileBackgroundImageUrl!))
        avatar.sd_setImageWithURL(NSURL(string: self.user!.profileImageUrl!))
        usernameLabel.text = self.user!.name
        
        
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
