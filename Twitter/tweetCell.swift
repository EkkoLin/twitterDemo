//
//  tweetCell.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 2/26/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var tweet : Tweet? {
        didSet {
            nameLabel.text = tweet?.name
            descriptionLabel.text = tweet?.text
            time.text = tweet?.time
            
            if let imageUrl = tweet?.userImage
            {
                posterView.setImageWith(imageUrl)
            }
        }
    }
    
    @IBAction func onFavoriteButton(_ sender: UIButton) {
        tweet?.favoriteCount += 1
    }
    
    
    @IBAction func onRetweetButton(_ sender: UIButton) {
        tweet?.retweetCount += 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterView.layer.cornerRadius = 5
        posterView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
