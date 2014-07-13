//
//  User.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 12/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

/*
{
"user_information": {
"username": "mattdelves",
"gravatar": "b9e70313e319e2d5e8e1722457e33f4f",
"level": 1,
"title": "Guppies",
"about": "",
"website": null,
"twitter": null,
"topics_count": 0,
"posts_count": 0,
"creation_date": 1378959294,
"vacation_date": null
},
"requested_information": {
"...": "..."
}
}
*/

import Foundation

class User {
  var name: String?
  var gravatar: String?
  var level: Int?
  var title: String?
  var about: String?
  var website: String?
  var twitter: String?
  var topics_count: Int?
  var posts_count: Int?
  var creation_date: String?
  var vacation_date: String?
  
  init(_ userInfo: NSDictionary) {
    self.name = userInfo["username"] as? String
    self.gravatar = userInfo["gravatar"] as? String
    self.level = userInfo["level"] as? Int
    self.title = userInfo["title"] as? String
    self.about = userInfo["about"] as? String
    self.website = userInfo["website"] as? String
    self.twitter = userInfo["twitter"] as? String
    self.topics_count = userInfo["topics_count"] as? Int
    self.posts_count = userInfo["posts_count"] as? Int
    self.creation_date = userInfo["creation_date"] as? String
    self.vacation_date = userInfo["vacation_date"] as? String
  }
}