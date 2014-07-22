//
//  Radicals.swift
//  WaniKaniKit
//
//  Created by Matthew Delves on 12/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Foundation

public class Radical {
  public var character: String!
  public var meaning: String!
  public var image: String!
  public var user_specific: NSDictionary!
  
  public init(_ radicalInfo: NSDictionary) {
    self.character = radicalInfo["character"] as? String
    self.meaning   = radicalInfo["meaning"] as? String
    self.image     = radicalInfo["image"] as? String
    self.user_specific = radicalInfo["user_specific"] as? NSDictionary
  }
}
