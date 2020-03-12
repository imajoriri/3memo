//
//  MemoModel.swift
//  3m
//
//  Created by imajo-takeyuki on 2020/03/10.
//  Copyright © 2020 imajo. All rights reserved.
//

import Foundation
import Firebase

struct Memo: Identifiable {
  var id:String = "id"
  var fact:String = ""
  var abstruct:String = ""
  var product:String = ""
  var createdAt:Date
  
  init(id:String? = nil, fact:String = "", abstruct:String = "", product:String = "", createdAt:Date = Date()) {
    self.createdAt = createdAt
    // idは初期値は自動生成
    if id == nil {
      self.id = createId(length: 10)
    } else {
      self.id = id!
    }
    self.fact = fact
    self.abstruct = abstruct
    self.product = product
    
  }
  
  func createId(length: Int) -> String {

      let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      let len = UInt32(letters.length)

      var randomString = ""

      for _ in 0 ..< length {
          let rand = arc4random_uniform(len)
          var nextChar = letters.character(at: Int(rand))
          randomString += NSString(characters: &nextChar, length: 1) as String
      }

      return randomString
  }
}

class MemoModel {
  var db:Firestore = Firestore.firestore()
  
  static func delete(memo: Memo) {
    let me:UserModel = UserModel.getMe()
    let db = Firestore.firestore()
    db.collection("users").document(me.uuid).collection("memos").document(memo.id).delete() { err in
      if let err = err {
        print("Error removing document: \(err)")
      } else {
        print("Document successfully removed!")
      }
    }
  }
  
  static func save(memo: Memo) {
    let me:UserModel = UserModel.getMe()
    let db = Firestore.firestore()
    
    db.collection("users").document(me.uuid).collection("memos").document(memo.id).setData([
      "fact": memo.fact,
      "abstruct": memo.abstruct,
      "product": memo.product,
      "createdAt": memo.createdAt
    ]) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
  }

  static func getAllMemo(complete: @escaping(Array<Memo>)->() ) {
    let me:UserModel = UserModel.getMe()
    let db = Firestore.firestore()
    var results:Array<Memo> = []
    
    db.collection("users").document(me.uuid).collection("memos").order(by: "createdAt", descending: true).addSnapshotListener { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
        complete([])
      } else {
        // resultsに前回の値を保持しているので一度クリア
        results = []
        for document in querySnapshot!.documents {
          let id:String = document.documentID
          var fact = ""
          if let bindFact = document.get("fact") as? String { fact = bindFact }
          var abstruct = ""
          if let bindAbstruct = document.get("abstruct") as? String { abstruct = bindAbstruct }
          var product = ""
          if let bindProduct = document.get("product") as? String { product = bindProduct }
          var createdAt = Date()
          if let bindCreatedAt = document.get("createdAt") as? Date { createdAt = bindCreatedAt }
          results.append(Memo(id: id, fact: fact, abstruct: abstruct, product: product, createdAt: createdAt))
        }
      }
      print(String(results.count))
      complete(results)
    }
  }
}
