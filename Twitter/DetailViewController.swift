//
//  DetailViewController.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 3/5/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet : Tweet!
    
    @IBOutlet weak var toProfileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = tweet.name
        self.overviewLabel.text = tweet.text!
        self.time.text = tweet.time
        self.retweetCountLabel.text = String(tweet.retweetCount)
        self.favoriteCountLabel.text = String(tweet.favoriteCount)
        
        if let imageUrl = tweet?.userImage
        {
            self.profileImage.setImageWith(imageUrl)
        }
        self.profileImage.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onRetweetButton(_ sender: UIButton) {
        if tweet.retweeted == false{
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"),for: UIControlState.normal)
            tweet.retweetCount += 1
            tweet.retweeted = true
        }else {
            tweet.retweetCount -= 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"),for: UIControlState.normal)
            tweet.retweeted = false
            
        }
    }
    
    
    @IBAction func onFavoriteButton(_ sender: UIButton) {
        if tweet.favorited == false {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"),for: UIControlState.normal)
            tweet.favoriteCount += 1
            tweet.favorited = true
        }else {
            tweet.favoriteCount -= 1
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"),for: UIControlState.normal)
            tweet.favorited = false
            
        }
    }
    
    @IBAction func onHomeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onReplyBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
 
    }*/
}

