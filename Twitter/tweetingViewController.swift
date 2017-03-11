//
//  tweetingViewController.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 3/6/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class tweetingViewController: UIViewController{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var textLabel: UITextField!
    
    var user: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display setup
        let imageURL = user["profile_image_url_https"] as? String
        var userImage: URL!
        if imageURL != nil {
            print("url: \(imageURL)")
            userImage = URL(string: imageURL!)!
        } else {
            userImage = nil
        }
        profileImage.setImageWith(userImage)
        nameLabel.text = user["name"] as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
