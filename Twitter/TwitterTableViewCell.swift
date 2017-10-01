//
//  TwitterTableViewCell.swift
//  Twitter
//
//  Created by Nanxi Kang on 9/29/17.
//  Copyright © 2017 Nanxi Kang. All rights reserved.
//

import AFNetworking
import UIKit

class TwitterTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var userFullnameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func set(_ tweet: Tweet) {
        if let text = tweet.text {
            contentLabel.text = text
            contentLabel.sizeToFit()
        }
        if let user = tweet.author {
            if let username = user.name {
                userFullnameLabel.text = username
            }
            if let url = user.profileUrl {
                userProfileImageView.setImageWith(url)
            }
            if let screenName = user.screenName {
                usernameLabel.text = "@\(screenName)"
            }
        }
        if let date = tweet.createdAt {
            dateLabel.text = TwitterTableViewCell.getApproximateTime(dateString: date)
        }
    }
    
    private class func getApproximateTime(dateString: String) -> String {
        let date = parseDate(string: dateString)
        if let date = date {
            let intervalInt = Int(-date.timeIntervalSinceNow)
            let NUM_AND_DATE: [(Int, String)] = [(365 * 24 * 60 * 60, "y"), (12 * 24 * 60 * 60, "m"), (24 * 60 * 60, "d"), (60 * 60, "h"), (60, "m"), (1, "s")]
            for item in NUM_AND_DATE {
                let num: Int = intervalInt / item.0
                if (num > 0) {
                    return "\(num)\(item.1)"
                }
            }
        }
        return "Unknown"
    }
    
    private class func parseDate(string: String) -> Date? {
        //"Thu Apr 06 15:24:15 +0000 2017"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss +zzzz yyyy"
        //dateFormatter.locale = Locale.init(identifier: "en_GB")
        let dateObj = dateFormatter.date(from: string)
        return dateObj
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
