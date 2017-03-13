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
    
    var user: User!
    var message: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display setup
        profileImage.setImageWith(user.profileUrl!)
        nameLabel.text = user.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func compose(_ sender: UIBarButtonItem) {
        message = textLabel.text
        let paramsDict: NSDictionary = NSDictionary(dictionary: ["status" : message!])
        
        TwitterClient.sharedInstance.compose(tweetText: message!, params: paramsDict, completion: { (error) -> () in
            print("Successfully compose")
            print(error?.localizedDescription)
        })
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
