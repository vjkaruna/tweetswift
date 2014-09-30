//
//  ComposeController.swift
//  tweetswift
//
//  Created by Vijay Karunamurthy on 9/30/14.
//  Copyright (c) 2014 vjkaruna. All rights reserved.
//

import UIKit

class ComposeController: UIViewController {

    @IBOutlet weak var composeText: UITextField!
    
    @IBAction func postTweetAction(sender: AnyObject) {
        TwitterClient.sharedInstance.postTweetWithParams(["status":self.composeText.text], completion: { (error) -> () in
            println("posted tweet!")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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