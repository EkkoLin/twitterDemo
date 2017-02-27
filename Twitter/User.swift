//
//  User.swift
//  TwitterDemo
//
//  Created by Ekko Lin on 2/20/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    static let userDidLogoutNotification = NSNotification.Name(rawValue: "UserDidLogout")
    
    // deseralization
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            let defaults = UserDefaults.standard
            
            if _currentUser == nil {
                if let userData = defaults.object(forKey: "currentUserData") as? Data {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    
    }
}
