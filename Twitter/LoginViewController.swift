//
//  LoginViewController.swift
//  Twitter
//
//  Created by Ekko Lin on 2/19/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL:URL(string:"https://api.twitter.com")!, consumerKey: "CQig7WUK2IGaBbYg1ftNidAAB", consumerSecret: "KGtXeZX2ti1gL9MdhS4XrajwJqZT3HQNR7XF7fkJrbAcPSCiSg")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken) in
            print("I got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
            UIApplication.shared.open(url)
            
        }, failure: { (error) in
            print("Error: \(error?.localizedDescription)")
        })
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


