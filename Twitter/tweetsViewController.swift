//
//  tweetsViewController.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 2/21/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class tweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Settings for table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets : [Tweet]) in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text!)
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adding a logout button
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    // Table view delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell;
    }
    
    
    func favorTweet(_ tweet: Tweet) {
        if let index = tweets.index(of: tweet) {
            let indexPath = IndexPath(row: index, section: 0)
            
            TwitterClient.sharedInstance.favorite(id: (tweet.id)!, success: { (tweet) in
                self.tweets[index] = tweet
                
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }) { (error) in
                
            }
        }
        
    }
    
    
    func retweet(_ tweet: Tweet) {
        if let index = tweets.index(of: tweet) {
            
            let indexPath = IndexPath(row: index, section: 0)
            print(tweet.favorited)
            TwitterClient.sharedInstance.retweet(id: (tweet.id)!, success: { (tweet) in
                self.tweets[index] = tweet
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }) { (error) in
                
            }
        }
    }
    
    func favorDetailTweet(_ tweet: Tweet) {
        if let index = tweets.index(of: tweet) {
            let indexPath = IndexPath(row: index, section: 0)
            
            TwitterClient.sharedInstance.favorite(id: (tweet.id)!, success: { (tweet) in
                self.tweets[index] = tweet
                
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }) { (error) in
                
            }
        }
    }
    
    func retweetDetail(_ tweet: Tweet) {
        if let index = tweets.index(of: tweet) {
            
            let indexPath = IndexPath(row: index, section: 0)
            print(tweet.favorited)
            TwitterClient.sharedInstance.retweet(id: (tweet.id)!, success: { (tweet) in
                self.tweets[index] = tweet
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }) { (error) in
                
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)
//        let tweet = tweets![indexPath!.row]
        
//        
//        let vc = navController.topViewController as! DetailViewController
//        vc.tweet = tweet
        
        if let sender = sender as? tweetCell{
//            let cell = sender as! UITableViewCell
//            let indexPath = tableView.indexPath(for: sender)
//            let navController = segue.destination as! UINavigationController
//            let vc = navController.topViewController as! DetailViewController
//            vc.tweet = cell.tweet
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets[indexPath!.row]
            let navVC = segue.destination as? UINavigationController
            let detailedVC = navVC?.viewControllers.first as! DetailViewController
            
            detailedVC.tweet = tweet
        } else if let sender = sender as? UIBarButtonItem {
            if sender.image! == UIImage(named: "edit-icon")! {
                let navVC = segue.destination as? UINavigationController
                let composeVC = navVC?.viewControllers.first as! tweetingViewController
                
                composeVC.user = User.currentUser
            }
        } else {
            let navVC = segue.destination as? UINavigationController
            let vc = navVC?.viewControllers.first as! profileViewController
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! tweetCell
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            vc.user = tweet.userDict
        }
    }
}
