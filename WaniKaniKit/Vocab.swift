//
//  Vocab.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 12/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Foundation

public class Vocab {
  public var character: String!
  public var kana: String!
  public var meaning: String!
  public var level: Int!
  public var user_specific: String!
  
  public init(_ values: NSDictionary) {
    self.character     = values["character"] as? String
    self.kana          = values["kana"] as? String
    self.meaning       = values["meaning"] as? String
    self.level         = values["level"] as? Int
    self.user_specific = values["user_specific"] as? String
  }
}