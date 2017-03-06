//
//  DetailViewController.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 3/5/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var toProfileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!

    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = tweet?.name
        self.overviewLabel.text = tweet?.text
        self.time.text = tweet?.time
        self.retweetLabel.text = "\(tweet?.retweetCount)"
        self.favoriteLabel.text = "\(tweet?.favoriteCount)"
        
        if let imageUrl = tweet?.userImage
        {
            self.profileImage.setImageWith(imageUrl)
        }
        self.profileImage.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyButton(_ sender: UIButton) {
    }
    
    
    @IBAction func onRetweetButton(_ sender: UIButton) {
    }
    
    
    @IBAction func onFavoriteButton(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
