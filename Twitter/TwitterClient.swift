//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 2/21/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    

    
    static let sharedInstance = TwitterClient(baseURL:URL(string:"https://api.twitter.com")!, consumerKey: "CQig7WUK2IGaBbYg1ftNidAAB", consumerSecret: "KGtXeZX2ti1gL9MdhS4XrajwJqZT3HQNR7XF7fkJrbAcPSCiSg")
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () ->(), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken) in
            print("I got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
            UIApplication.shared.open(url)
            
        }, failure: { (error) in
            print("Error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User._currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            
            self.currentAccount(success: { (user) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error) in
                self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
        }, failure:{ (error) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json",parameters: nil,progress: nil,success: { (task, response) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task, error) in
            failure(error)
        })
    }
}
