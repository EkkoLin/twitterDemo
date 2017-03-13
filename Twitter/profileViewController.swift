//
//  profileViewController.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 3/5/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var user: NSDictionary!
    var tweet: NSDictionary!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display setting
        nameLabel.text = user["name"] as? String
        let followers = user["followers_count"] as! Int
        followerCountLabel.text = String(followers)
        print(user["following"] ?? 0)
        let following = user["friends_count"] as! Int
        followingCountLabel.text = String(following)
        print(user["following"] ?? 0)
        let listed_count = user["listed_count"] as! Int
        tweetsCountLabel.text = String(listed_count)
        print(user["listed_count"] ?? 0)
        
        let imageURL = user["profile_image_url_https"] as? String
        var userImage: URL!
        if imageURL != nil {
            print("url: \(imageURL)")
            userImage = URL(string: imageURL!)!
        } else {
            userImage = nil
        }
        
       iconImage.setImageWith(userImage)
        
        let profileImageURL = user["profile_background_image_url_https"] as? String
        var userProfileImageUrl: URL!
        if profileImageLabel != nil {
            print("url: \(profileImageURL)")
            userProfileImageUrl = URL(string: profileImageURL!)!
        } else {
            userImage = nil
        }
        
        profileImageLabel.setImageWith(userProfileImageUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onFriendButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let sender = sender as? UIBarButtonItem {
            if sender.image! == UIImage(named: "edit-icon")! {
                let navVC = segue.destination as? UINavigationController
                let composeVC = navVC?.viewControllers.first as! tweetingViewController
            
                composeVC.user = User.currentUser
            }
        }
    }
    
}
