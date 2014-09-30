//
//  PullToRefreshView.swift
//  LayoutDemo
//
//  Created by Ben Sandofsky on 9/22/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit
class PullToRefreshView: UIView {
    enum State {
        case Default
        case Prompting
        case Refreshing
    }
    var state:State = .Default {
        didSet(value){
            switch(self.state){
            case .Default:
                pullPromptLabel.text = "Pull to refresh"
            case .Prompting:
                pullPromptLabel.text = "Release to Refresh"
            case .Refreshing:
                pullPromptLabel.text = "Refreshing"
            }
        }
    }
    @IBOutlet weak var pullPromptLabel: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
    // Drawing code
    }
    */
    
}