//
//  WaniKaniAPI.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 11/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Foundation

class WaniKaniAPI {
  var baseUrl: String
  var session: NSURLSession
  var apiVersion: String
  var apiKey: String
  
  init(_ url: String!, apiVersion: String!, apiKey: String! ) {
    self.baseUrl = url
    self.session = NSURLSession.sharedSession()
    self.apiVersion = apiVersion
    self.apiKey = apiKey
  }
  
  func updateUserInfo(completion: (user: User) -> Void) {
    // https://www.wanikani.com/api/user/56223fbda0bff89c3ba30e2983f4e21c/user-information
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/user-information"
    JSONDataForEndpoint(urlString, completion: { json in
      let userInfo: AnyObject! = json["user_information"]
      let user = User(userInfo as NSDictionary)
      completion(user: user)
      
      })
  }
  
  func retrieveVocabList(level: Int, completion: (vocab: [Vocab]) -> Void) {
    
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/vocabulary/\(level)"
    JSONDataForEndpoint(urlString, completion: { json in
      let vocabInfo: [NSDictionary] = json["requested_information"] as [NSDictionary]
      var vocabulary: [Vocab] = [Vocab]()
      
      for vocabFound : NSDictionary in vocabInfo {
        vocabulary.append(Vocab(vocabFound))
      }
      
      completion(vocab: vocabulary)
      
      })
  }
  
  func retrieveRadicacalsList(level: Int, completion: (radicals: [Radical]) -> Void) {
    // https://www.wanikani.com/api/user/56223fbda0bff89c3ba30e2983f4e21c/radicals/1
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/radicals/\(level)"
    
    JSONDataForEndpoint(urlString, completion: {json in
      let radicalInfo: [NSDictionary] = json["requested_information"] as [NSDictionary]
      var radicals: [Radical] = [Radical]()
      
      for radicalFound: NSDictionary in radicalInfo {
        radicals.append(Radical(radicalFound))
      }
      
      completion(radicals: radicals)
      
      })
  }
  
  func JSONDataForEndpoint(url: String, completion: (NSDictionary) -> Void) {
    let task = session.dataTaskWithRequest(NSURLRequest(URL: NSURL(string: url)), completionHandler: { data, response, error in
      var code = (response as NSHTTPURLResponse).statusCode
      if(code != 200) {
        println("I didn't get a valid response back. Instead I got \(code)")
        return
      }
      
      var error: NSError?
      var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary

      completion(json)
      })
    
    task.resume()
  }
  
}