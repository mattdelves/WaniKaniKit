//
//  WaniKaniAPI.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 11/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Foundation

public class WaniKaniAPI {
  var baseUrl: String
  var session: NSURLSession
  var apiVersion: String
  var apiKey: String
  
  public init(_ url: String!, apiVersion: String!, apiKey: String!, configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration() ) {
    self.baseUrl = url
    self.session = NSURLSession(configuration: configuration)
    self.apiVersion = apiVersion
    self.apiKey = apiKey
  }
  
  public func updateUserInfo(completion: (user: User) -> Void) {
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/user-information"
    println("updateUserInfo has been called")
    JSONDataForEndpoint(urlString) { json in
      let userInfo: AnyObject! = json["user_information"]
      let user = User(userInfo as NSDictionary)
      completion(user: user)
      
    }
  }
  
  public func retrieveVocabList(level: Int, completion: (vocab: [Vocab]) -> Void) {
    
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/vocabulary/\(level)"
    JSONDataForEndpoint(urlString) { json in
      let vocabInfo: [NSDictionary] = json["requested_information"] as [NSDictionary]
      var vocabulary: [Vocab] = [Vocab]()
      
      for vocabFound : NSDictionary in vocabInfo {
        vocabulary.append(Vocab(vocabFound))
      }
      
      completion(vocab: vocabulary)
      
    }
  }
  
  public func retrieveRadicacalsList(level: Int, completion: (radicals: [Radical]) -> Void) {
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/radicals/\(level)"
    
    JSONDataForEndpoint(urlString) {json in
      let radicalInfo: [NSDictionary] = json["requested_information"] as [NSDictionary]
      var radicals: [Radical] = [Radical]()
      
      for radicalFound: NSDictionary in radicalInfo {
        radicals.append(Radical(radicalFound))
      }
      
      completion(radicals: radicals)
      
    }
  }
  
  public func retrieveKanjiList(level: Int, completion: (kanji: [Kanji]) -> Void) {
    var urlString = "\(baseUrl)/api/\(apiVersion)/user/\(apiKey)/kanji/\(level)"
    
    JSONDataForEndpoint(urlString) {json in
      let kanjiInfo: [NSDictionary] = json["requested_information"] as [NSDictionary]
      var kanji: [Kanji] = [Kanji]()
      
      for kanjiFound: NSDictionary in kanjiInfo {
        kanji.append(Kanji(kanjiFound))
      }
      
      completion(kanji: kanji)
      
    }
  }
  
  func JSONDataForEndpoint(url: String, completion: (NSDictionary) -> Void) {
    let task = session.dataTaskWithURL(NSURL(string: url)!) { data, response, error in
      var code = (response as NSHTTPURLResponse).statusCode
      if(code != 200) {
        println("I didn't get a valid response back. Instead I got \(code)")
        return
      }
      var error: NSError?
      var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary

      completion(json)
    }
    
    task.resume()
  }
  
}