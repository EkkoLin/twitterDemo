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
    

    
    //static let sharedInstance = TwitterClient(baseURL:URL(string:"https://api.twitter.com")!, consumerKey: "CQig7WUK2IGaBbYg1ftNidAAB", consumerSecret: "KGtXeZX2ti1gL9MdhS4XrajwJqZT3HQNR7XF7fkJrbAcPSCiSg")
    
    
    static var sharedInstance: TwitterClient {
        struct Static {
            static let instance  = TwitterClient(
                baseURL:URL(string:"https://api.twitter.com")!,
                consumerKey: "CQig7WUK2IGaBbYg1ftNidAAB",
                consumerSecret: "KGtXeZX2ti1gL9MdhS4XrajwJqZT3HQNR7XF7fkJrbAcPSCiSg")
        }
        
        return Static.instance!
    }
    
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
    
    
    func retweet(id : String, success: @escaping ((Tweet) -> ()), failure : @escaping
        (Error) -> ()) {
        post("1.1/statuses/retweet/\(id).json",
            parameters: nil,
            progress: nil,
            success: { (task, response) in
                print("retweet succeeded")
                let dictionary = response as! NSDictionary
                let tweet = Tweet(dictionary: dictionary)
                print("retweetcount: \(tweet.retweetCount)")
                print("favorcount: \(tweet.favoriteCount)")
                success(tweet)
        }, failure: { (task, error) in
            print("1.1/statuses/retweet/\(id).json")
            print("retweet failed \(error.localizedDescription)")
            failure(error)
        })
    }
    
    
    func favorite(id : String, success: @escaping ((Tweet) -> ()), failure : @escaping
        (Error) -> ()) {
        post("1.1/favorites/create.json?id=\(id)",
            parameters: nil,
            progress: nil,
            success: { (task, response) in
                print("favor succeeded")
                let dictionary = response as! NSDictionary
                let tweet = Tweet(dictionary: dictionary)
                print("retweetcount: \(tweet.retweetCount)")
                print("favorcount: \(tweet.favoriteCount)")
                success(tweet)
        }, failure: { (task, error) in
            print("favor failed \(error.localizedDescription)")
            failure(error)
        })
    }
    
    
    func compose(tweetText : String, params: NSDictionary?, completion: @escaping (_ error: Error?) -> ()) {
        post("1.1/statuses/update.json",
             parameters: params,
             progress: nil,
             success: {(operation: URLSessionDataTask!, response: Any?) -> Void in
                print("tweet succeeded: \(tweetText)")
                completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            completion(error as Error?)
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
