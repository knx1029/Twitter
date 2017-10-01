//
//  TwitterClient.swift
//  Twitter
//
//  Created by Nanxi Kang on 9/29/17.
//  Copyright © 2017 Nanxi Kang. All rights reserved.
//

import AFNetworking
import BDBOAuth1Manager
import Foundation

class TwitterClient {
    
    private static var client: BDBOAuth1SessionManager! = getTwitterClient()
    
    class func deauthorize() {
        TwitterClient.client.deauthorize()
    }
    
    class func fetchRequestToken() {
        client.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitternkang://oauth"), scope: nil, success: TwitterClient.succeedOnRequestToken, failure: TwitterClient.failedOnRequestToken)
    }
    
    class func authorize(url: URL, doSomething: @escaping () -> Void) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        client.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(credsOpt: BDBOAuth1Credential?) -> Void in doSomething() }, failure: self.failedOnAccessToken)
    }
    
    class func fetchTweets(count: Int, processTweets: @escaping ([Tweet]) -> Void) {
        client.get("1.1/statuses/home_timeline.json?count=\(count)", parameters: nil, progress: nil, success: { (dataTask: URLSessionDataTask, response: Any) -> Void in
            if let tweetDicts = response as? [NSDictionary] {
                let tweets = Tweet.tweets(fromArray: tweetDicts)
                processTweets(tweets)
            }
        }, failure: { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            print("Error in fetching tweets: \(error.localizedDescription)")
        })
    }
    
    class func getUser(processUser: @escaping (User) -> Void) {
        client.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (dataTask: URLSessionDataTask, response: Any) -> Void in
            if let userDict = response as? NSDictionary {
                let user = User(dict: userDict)
                processUser(user)
            }
        }, failure: { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            print("Error in getting User: \(error.localizedDescription)")
        })
    }
    
    private class func failedOnAccessToken(error: Error?) {
        print("Error in fetching AccessToken: \(error?.localizedDescription)")
    }
    
    private class func succeedOnRequestToken(credsOpt: BDBOAuth1Credential?) {
        if let creds = credsOpt {
            let urlString = "https://api.twitter.com/oauth/authorize?oauth_token=\(creds.token!)"
            let url = URL(string: urlString)!
            UIApplication.shared.open(url)
        }
    }
    
    private class func failedOnRequestToken(error: Error?) {
        print("Error in fetching RequestToken \(error?.localizedDescription)")
    }
    
    private class func getTwitterClient() -> BDBOAuth1SessionManager {
        let BASE_URL = URL(string: "https://api.twitter.com")
        let CONSUMER_KEY = "zLmIgfBezuLfmAjw25OzF2xtg"
        let CONSUMER_SECRET = "eMKLe0vcdabPdUPwO5k1OXzrLntJSRgW9bREsorSVCRcBcwEUC"
        
        let client = BDBOAuth1SessionManager(baseURL: BASE_URL, consumerKey: CONSUMER_KEY, consumerSecret: CONSUMER_SECRET)!
        return client
    }
}
