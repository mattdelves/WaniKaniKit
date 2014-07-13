//
//  Vocab.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 12/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Foundation

class Vocab {
  var character: String?
  var kana: String?
  var meaning: String?
  var level: Int?
  var user_specific: String?
  
  init(_ values: NSDictionary) {
    self.character     = values["character"] as? String
    self.kana          = values["kana"] as? String
    self.meaning       = values["meaning"] as? String
    self.level         = values["level"] as? Int
    self.user_specific = values["user_specific"] as? String
  }
}