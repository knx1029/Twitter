//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Nanxi Kang on 9/30/17.
//  Copyright © 2017 Nanxi Kang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tweetsTable: UITableView!
    
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add top refresher
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tweetsTable.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Home"
        tweetsTable.delegate = self
        tweetsTable.dataSource = self
        self.fetchTweets(doSomething: {() -> Void in })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Implementing UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    // Create a cell to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TwitterTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.set(tweet)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is UINavigationController) {
            let controller = segue.destination as! UINavigationController
            let vc = controller.topViewController!
            if (vc is LoginViewController) {
                print("logout Tapped")
                User.currentUser = nil
            } else if (vc is NewTweetViewController) {
                print("new tweet")
                let newTweetVc = vc as! NewTweetViewController
                newTweetVc.tweetId = nil
            } else {
                print("transit to \(type(of: vc))")
            }
        } else if (segue.destination is TweetDetailsViewController){
            let vc = segue.destination as! TweetDetailsViewController
            let indexPath = tweetsTable.indexPath(for: sender as! TwitterTableViewCell)!
            tweetsTable.deselectRow(at: indexPath, animated: true)
            let tweet = self.tweets[indexPath.row]
            vc.tweet = Tweet(copyFrom: tweet)
        }
    }
    
    private func fetchTweets(doSomething: @escaping () -> Void) {
        TwitterClient.fetchTweets(count: 20, processTweets: {(tweets: [Tweet]) -> Void in
            /*for tweet in tweets {
                print("tweet: \(tweet.toString())")
            }*/
            self.tweets = tweets
            self.tweetsTable.reloadData()
            doSomething()
        })
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        print("refresh!")
        fetchTweets(doSomething: refreshControl.endRefreshing)
    }
    
    func addTweet(tweet: Tweet) {
        self.tweets = [tweet] + self.tweets
        self.tweetsTable.reloadData()
    }
}
