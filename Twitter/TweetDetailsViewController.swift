//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Nanxi Kang on 9/30/17.
//  Copyright © 2017 Nanxi Kang. All rights reserved.
//

import AFNetworking
import UIKit

class TweetDetailsViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            if let text = tweet.text {
                contentLabel.text = text
                contentLabel.sizeToFit()
            }
            if let user = tweet.author {
                if let username = user.name {
                    fullnameLabel.text = username
                }
                if let screenName = user.screenName {
                    usernameLabel.text = "@\(screenName)"
                }
                if let url = user.profileBiggerUrl {
                    profileImageView.setImageWith(url)
                }
            }
            
            if let date = tweet.createdAt {
                timeLabel.text = date
            }
            if tweet.favorited {
                favoriteButton.setImage(UIImage(named: "fav"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        } else {
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        replyButton.setImage(UIImage(named: "reply"), for: .normal)
        retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
