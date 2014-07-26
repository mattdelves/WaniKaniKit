//
//  Kanji.swift
//  WaniKaniKit
//
//  Created by Matthew Delves on 22/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Foundation

/*
{
"character": "入",
"meaning": "enter",
"onyomi": "にゅう",
"kunyomi": "はい.る, い.れる",
"important_reading": "onyomi",
"level": 1,
"user_specific": null
}
 */

public class Kanji {
  public var character: String!
  public var meaning: String!
  public var onyomi: String!
  public var kunyomi: String!
  public var important_reading: String!
  public var level: Int!
  public var user_specific: String!
  
  public init(_ values: NSDictionary) {
    self.character     = values["character"] as? String
    self.meaning       = values["meaning"] as? String
    self.onyomi        = values["onyomi"] as? String
    self.kunyomi       = values["kunyomi"] as? String
    self.important_reading = values["important_reading"] as? String
    self.level         = values["level"] as? Int
    self.user_specific = values["user_specific"] as? String
  }

}