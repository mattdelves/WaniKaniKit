//
//  WaniKaniAPISpec.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 12/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import Quick
import Nimble
import WaniKaniKit
import DummySpit

class WaniKaniAPISpec: QuickSpec {
  override func spec() {
    var api: WaniKaniAPI?
    
    beforeSuite({
      let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
      let urlProtocolClass: AnyObject = ClassUtility.classFromType(DummySpitURLProtocol.self)
      configuration.protocolClasses = [urlProtocolClass]
      api = WaniKaniAPI("mock://www.wanikani.com", apiVersion: "v1.2", apiKey: "12345678abcdefg", configuration: configuration)
      })
    
    describe("user retrieval", {
      
      beforeEach({
        let filePath = NSBundle(forClass: WaniKaniAPISpec.self).pathForResource("user", ofType: "json")
        let response = DummySpitServiceResponse(filePath: filePath, header: ["Content-type": "application/json"], urlComponentToMatch: "user-information")
        DummySpitURLProtocol.cannedResponse(response)
      })
      
      afterEach({
        DummySpitURLProtocol.cannedResponse(nil)
      })
      
      it("gets the details via the api", {
        var called = false

        api!.updateUserInfo({ user in
          called = true
          expect(user.name).to(equal("dummyUser"))
          })
        
        expect{called}.toEventually(beTruthy())
        })
      
      })

    describe("vocab retrieval", {
      beforeEach({
        let filePath = NSBundle(forClass: WaniKaniAPISpec.self).pathForResource("vocab", ofType: "json")
        let response = DummySpitServiceResponse(filePath: filePath, header: ["Content-type": "application/json"], urlComponentToMatch: "vocabulary")
        DummySpitURLProtocol.cannedResponse(response)
      })
      
      afterEach({
        DummySpitURLProtocol.cannedResponse(nil)
      })
      
      it("retrieves a list of vocab", {
        
        var called = false
        api!.retrieveVocabList(1, completion: { vocabList in
          called = true
          expect(vocabList.count).to(equal(41))
          })
        
        expect(called).toEventually(beTruthy())
        
        })
      })
    
    describe("radicals retrieval", {
      beforeEach({
        let filePath = NSBundle(forClass: WaniKaniAPISpec.self).pathForResource("radicals", ofType: "json")
        let response = DummySpitServiceResponse(filePath: filePath, header: ["Content-type": "application/json"], urlComponentToMatch: "radicals")
        DummySpitURLProtocol.cannedResponse(response)
      })
      
      afterEach({
        DummySpitURLProtocol.cannedResponse(nil)
      })
      
      it("retrieves a list of radicals available for a level", {
        var called = false
        var radicalsList: [Radical]
        
        api!.retrieveRadicacalsList(1, completion: { radicalsList in
          called = true
          expect(radicalsList.count).to(equal(26))
          })
        
        expect{called}.toEventually(beTruthy())
      })
    })

    describe("kanji retrieval", {
      beforeEach({
        let filePath = NSBundle(forClass: WaniKaniAPISpec.self).pathForResource("kanji", ofType: "json")
        let response = DummySpitServiceResponse(filePath: filePath, header: ["Content-type": "application/json"])
        DummySpitURLProtocol.cannedResponse(response)
      })
      
      afterEach({
        DummySpitURLProtocol.cannedResponse(nil)
      })
      
      it("retrieves a list of kanji available for a level", {
        var called = false
        
        api!.retrieveRadicacalsList(1, completion: { kanjiList in
          called = true
          expect(kanjiList.count).to(equal(18))
        })
        
        expect{called}.toEventually(beTruthy())
      })
    })
  }
  
}