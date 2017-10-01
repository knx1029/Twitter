//
//  LoginViewController.swift
//  Twitter
//
//  Created by Nanxi Kang on 9/28/17.
//  Copyright © 2017 Nanxi Kang. All rights reserved.
//

import BDBOAuth1Manager
import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.currentUser != nil {
            self.presentTweets()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogin(_ sender: Any) {
        TwitterClient.deauthorize()
        TwitterClient.fetchRequestToken()
    }
    
    func presentTweets() {
        print("present tweets")
        let controller = storyboard?.instantiateViewController(withIdentifier: "tweetsNaVC") as! UINavigationController
        // let vc = controller.topViewController as! TweetsViewController
        self.dismiss(animated: true, completion: nil)
        self.present(controller, animated: true)
    }
}
