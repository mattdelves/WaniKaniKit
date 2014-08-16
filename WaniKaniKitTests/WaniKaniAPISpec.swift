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

class WaniKaniAPISpec: QuickSpec {
  override func spec() {
    var api: WaniKaniAPI?
    
    beforeSuite({
      api = WaniKaniAPI("https://www.wanikani.com", apiVersion: "v1.2", apiKey: "56223fbda0bff89c3ba30e2983f4e21c")
      })
    
    describe("user retrieval", {
      
      it("gets the details via the api", {
        var called = false

        api!.updateUserInfo({ user in
          called = true
          expect(user.name).to(equal("mattdelves"))
          })
        
        expect{called}.toEventually(beTruthy(), timeout: 10)
        })
      
      })
    
    describe("vocab retrieval", {
      it("retrieves a list of vocab", {
        
        var called = false
        api!.retrieveVocabList(1, completion: { vocabList in
          called = true
          expect(vocabList.count).to(equal(41))
          })
        
        expect(called).toEventually(beTruthy(), timeout: 10)
        
        })
      })
    
    describe("radicals retrieval", {
      it("retrieves a list of radicals available for a level", {
        var called = false
        var radicalsList: [Radical]
        
        api!.retrieveRadicacalsList(1, completion: { radicalsList in
          called = true
          expect(radicalsList.count).to(equal(26))
          })
        
        expect{called}.toEventually(beTruthy(), timeout: 10)
      })
    })
  }
  
}